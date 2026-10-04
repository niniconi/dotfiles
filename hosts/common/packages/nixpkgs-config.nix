# nixpkgs policy, kept out of packages/default.nix because a host may import
# package groups directly and still has to obey this. The predicate below names
# packages from those groups.
{
  pkgs,
  ...
}:

{
  nixpkgs.config = {
    allowUnfree = false;
    allowUnfreePredicate =
      pkg:
      builtins.elem (pkgs.lib.getName pkg) [
        "volatility3" # memory forensics
        "unrar" # rar extraction
        # androidenv (objection dependency): composed wrappers use the
        # android-sdk-* prefix, raw archives use the bare package name.
        "android-sdk-cmdline-tools"
        "android-sdk-platform-tools"
        "android-sdk-build-tools"
        "android-sdk-cmake"
        "android-sdk-platforms"
        "android-sdk-sources"
        "android-sdk-tools"
        "android-sdk-emulator"
        "android-sdk-ndk"
        "cmdline-tools"
        "platform-tools"
        "build-tools"
        "cmake"
        "platforms"
        "sources"
        "tools"
        "emulator"
        "ndk"
        "ndk-bundle"
        "extras"
        "patcher"
        "skiaparser"
        "system-images"
        "addons"
      ];
    android_sdk.accept_license = true;
    permittedInsecurePackages = [
      "electron-39.8.10"
      "openclaw-2026.5.7"
    ];
  };
}
