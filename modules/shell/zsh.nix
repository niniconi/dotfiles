{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    lsd
    bat
    hexyl
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;

    # Powerlevel10k theme (replaces oh-my-zsh theme)
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];

    # Autosuggestions (replaces oh-my-zsh plugin)
    autosuggestion.enable = true;

    # Syntax highlighting (replaces oh-my-zsh plugin)
    syntaxHighlighting.enable = true;

    # Single initContent (replaces deprecated initExtraFirst/initExtra).
    # lib.mkBefore puts this at the very top of .zshrc,
    # which is required for p10k's instant prompt.
    initContent = lib.mkBefore ''
      # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
      # Initialization code that may require console input (password prompts, [y/n] confirmations, etc.) must go above this block; everything else may go below.
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi

      # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

      # import custom commands
      source ~/.zshrc_command
    '';

    # Aliases from dot_zshrc_alias (single source; Nix guarantees every
    # tool below is installed, so no runtime fallbacks are needed)
    shellAliases = {
      zshconf = "$EDITOR ~/.zshrc";
      nvimconf = "$EDITOR ~/.config/nvim";
      vimconf = "$EDITOR ~/.vimrc";
      termuxconf = "$EDITOR ~/.termux/termux.properties";
      sshconf = "$EDITOR ~/.ssh/config";
      tmuxconf = "$EDITOR ~/.config/tmux/tmux.conf";
      edhistory = "$EDITOR ~/.zsh_history";

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
      lltd = "lsd --tree -l";

      # tool overrides
      vim = "nvim";
      cat = "bat";
      hexdump = "hexyl";
      diff = "delta";
    };
  };

  # Deploy the commands file as raw file (editable by user)
  home.file = {
    ".zshrc_command".source = ./../../zsh/dot_zshrc_command;
  };

  # Set EDITOR for all sessions
  home.sessionVariables.EDITOR = "nvim";
}