{ inputs, outputs, lib, config, pkgs, ... }:
{


  home.packages = with pkgs; [

      #cli
      bash
      bat
      just
      fastfetch
      onefetch
      cpufetch
      ramfetch
      bottom
      eza
      git
      lazygit
      alacritty
      tldr
      tmux
      zoxide
      fzf
      atuin
      delta

      ripgrep
      difftastic

      (writeShellScriptBin "launchtmux" ''
        tmux has-session -t "nixmux"
        if [ $? != 0 ]; then
          tmux new-session -d -s "nixmux" -n bash 
          tmux new-window -n git -t nixmux
        fi
        tmux attach
        '')

  ];

  home.sessionVariables = {
    NIXPKGS_ALLOW_UNFREE=1;
  };

  programs.git = {
    enable = true;
    userName = "Matt Miller";
    userEmail = "mmiller@crispyecho.com";
    difftastic.enable = true;
    difftastic.color = "always";
    extraConfig = {
      credential = {
        helper = "store";
      };
    };
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      codetree = "eza -lr --tree";
    };
    
    bashrcExtra = ''
      export PS1='\[$(tput setaf 10)\]\u\[$(tput setaf 10)\]@\[$(tput setaf 10)\]\h:\w \[$(tput setaf 1)\]$(git branch 2>/dev/null | grep '"'"'*'"'"' | colrm 1 2)\[\033[00m\]> '
      eval "$(zoxide init bash)"
      if ! { [ "$TERM" = "screen-256color" ] && [ -n "$TMUX" ]; } then
        launchtmux
      fi
      source "$(blesh-share)"/ble.sh --attach=none
      ble-attach
      eval "$(atuin init bash)"
	'';
  };

  programs.alacritty = {
    enable = true;
    settings = {
  		font.normal.family = "FiraMono Nerd Font";
		font.size = 14;
		window.opacity = 0.75;
		window.decorations = "none";
      };
  };

  programs.tmux = {
  	enable = true;
  	shortcut = "a";
	baseIndex = 1;
    terminal = "screen-256color";
    extraConfig = ''
      set -g status-right "#[fg=green]%d %b %Y %l:%M %p"
      set -g status-bg black
      set -g status-fg green
    '';
  };

  programs.eza = {
      enable = true;
      icons = true;
      extraOptions = [
        "-lar"
        "--time-style=+%m/%d/%y %l:%M %P" 
      ];
      git = true;
    };

  programs.zoxide = {
      enable = true;
      enableBashIntegration = true;
  };

  services.ssh-agent = {
    enable = true;
  };

}
