{
  lib,
  userName,
  hostName,
  profiles,
  ...
}:

let
  profile = profiles.${hostName}.users.${userName} or { };
  git = profile.git or { };
in
{
  programs = {
    git = {
      enable = true;

      signing = lib.mkIf (git.signingKey or null != null) {
        key = git.signingKey;
        signByDefault = true;
      };

      settings = {
        user = {
          email = lib.mkIf (git.email or null != null) git.email;
          name = lib.mkIf (git.name or null != null) git.name;
        };
        merge.conflictStyle = "zdiff3";
      };
    };

    delta = {
      enable = true;
      enableGitIntegration = true;
      options = {
        navigate = true;
        dark = true;
        side-by-side = true;
      };
    };

    starship = {
      enable = true;
      enableZshIntegration = true;
      presets = [ "nerd-font-symbols" ];
      settings = {
        os = {
          disabled = false;
          symbols.NixOS = "󱄅 ";
        };
        git_branch = {
          symbol = " ";
        };
        character = {
          success_symbol = "[\\$](bold green)";
          error_symbol = "[\\$](bold red)";
        };
      };
    };

    zsh = {
      enable = true;
      enableCompletion = true;

      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      # $HOME is tmpfs while history lives on the persistent btrfs volume:
      # zsh saves by renaming $HISTFILE.new onto $HISTFILE, which fails with
      # EBUSY when HISTFILE is an impermanence bind mount. Write history
      # straight into the persistent directory instead.
      initContent = ''
        if [[ -d /persist/home/${userName} ]]; then
          export HISTFILE="/persist/home/${userName}/.zsh_history"
        fi
      '';

      shellAliases = {
        icat = "kitty +kitten icat";

        # lsd aliases
        ls = "lsd";
        lld = "lsd -l";
        ll = "lsd -l";
        lad = "lsd -a";
        llad = "lsd -a -l";
        ltd = "lsd --tree";
        latd = "lsd --tree -a";
        ltad = "lsd --tree -a";
        llatd = "lsd --tree -a -l";
        lltad = "lsd --tree -a -l";
        lltd = "lsd --tree -l";

        # tool overrides
        vim = "nvim";
        cat = "bat";
        hexdump = "hexyl";
        diff = "delta";
      };
    };
  };

  # Set EDITOR for all sessions
  home.sessionVariables.EDITOR = "nvim";
}
