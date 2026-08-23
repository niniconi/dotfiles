{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    lsd
    bat
    hexyl
    delta
  ];

  programs.git = {
    enable = true;
    settings = {
      merge.conflictStyle = "zdiff3";
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      navigate = true;
      dark = true;
      side-by-side = true;
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

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

  # Set EDITOR for all sessions
  home.sessionVariables.EDITOR = "nvim";
}
