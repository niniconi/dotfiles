# modules/validation.nix - Validate profiles structure for unknown fields
{ lib, profiles, ... }:

let
  # Valid fields at each level
  validHostFields = [
    "users"
    "sing-box"
    "wireguard"
  ];
  validUserFields = [
    "git"
    "ssh"
  ];
  validGitFields = [
    "name"
    "email"
    "signingKey"
  ];
  validSshFields = [
    "authorizedKeys"
    "hosts"
  ];
  validSshHostFields = [
    "hostname"
    "user"
    "port"
    "identityFile"
    "sopsSecret"
    "forwardX11"
    "extraOptions"
  ];
  validSingBoxFields = [
    "enable"
    "settings"
  ];
  validWireguardFields = [
    "enable"
    "interfaces"
  ];

  # Check function: returns null if valid, error message if invalid
  checkFields =
    validFields: context: attrs:
    let
      fields = builtins.attrNames attrs;
      unknown = lib.filter (f: !builtins.elem f validFields) fields;
    in
    if unknown == [ ] then
      null
    else
      "Unknown fields in ${context}: ${lib.concatStringsSep ", " unknown}";

  # Validate SSH hosts entries
  validateSshHosts =
    hostContext: hosts:
    lib.concatMap (
      hostName:
      let
        hostAttrs = if builtins.isAttrs hosts.${hostName} then hosts.${hostName} else { };
        error = checkFields validSshHostFields "${hostContext}.ssh.hosts.${hostName}" hostAttrs;
      in
      if error != null then [ error ] else [ ]
    ) (builtins.attrNames hosts);

  # Validate single user profile
  validateUser =
    hostName: userName: user:
    let
      context = "${userName}@${hostName}";
      errors = lib.filter (e: e != null) [
        (checkFields validUserFields "${context} user profile" user)
        (checkFields validGitFields "${context}.git" (user.git or { }))
        (checkFields validSshFields "${context}.ssh" (user.ssh or { }))
      ];
      sshHostErrors =
        if (user.ssh.hosts or { }) != { } then validateSshHosts context user.ssh.hosts else [ ];
    in
    errors ++ sshHostErrors;

  # Validate host profile
  validateHost =
    hostName: hostProfile:
    let
      hostErrors = lib.filter (e: e != null) [
        (checkFields validHostFields "host profile ${hostName}" hostProfile)
        (checkFields validSingBoxFields "${hostName}.sing-box" (hostProfile.sing-box or { }))
        (checkFields validWireguardFields "${hostName}.wireguard" (hostProfile.wireguard or { }))
      ];
      userErrors = lib.concatMap (
        userName: validateUser hostName userName ((hostProfile.users or { }).${userName} or { })
      ) (builtins.attrNames (hostProfile.users or { }));
    in
    hostErrors ++ userErrors;

  # Validate all hosts
  allErrors =
    if profiles == { } then
      [ ]
    else
      lib.concatMap (hostName: validateHost hostName (profiles.${hostName} or { })) (
        builtins.attrNames profiles
      );
in
{
  assertions = [
    {
      assertion = profiles == { } || allErrors == [ ];
      message = "Profile validation failed:\n${lib.concatStringsSep "\n" allErrors}";
    }
  ];
}
