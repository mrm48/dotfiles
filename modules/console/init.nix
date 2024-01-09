{ inputs, outputs, lib, config, pkgs, ... }:
{


  home.packages = with pkgs; [

      #cli
      bash
      bat
      just
      fastfetch
      bottom
      eza
      git
      gitui
      alacritty
      tldr
      tmux
      zoxide
      fzf

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

      (writeShellScriptBin "setup-gnome" ''
        # Set up keybindings for gnome convert this to an autostart script
        gsettings set org.gnome.desktop.wm.keybindings close "['<Super>w']"
        gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left "['<Shift><Super>k']"
        gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right "['<Shift><Super>j']"
        gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['<Super>k']"
        gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<Super>j']"
        gsettings set org.gnome.desktop.wm.keybindings move-to-monitor-left "['<Super>h']"
        gsettings set org.gnome.desktop.wm.keybindings move-to-monitor-right "['<Super>l']"
        gsettings set org.gnome.desktop.wm.keybindings minimize "['<Shift><Super>h']"
        gsettings set org.gnome.desktop.wm.keybindings maximize "['<Super>d']"
        gsettings set org.gnome.desktop.input-sources xkb-options "['terminate:ctrl_alt_bksp', 'altwin:swap_alt_win', 'caps:ctrl_modifier', 'ctrl:nocaps']"
        gsettings set org.gnome.shell disabled-extensions "['dash-to-panel@jderose9.github.com']"
        gsettings set org.gnome.shell enabled-extensions "['dash-to-dock@micxgx.gmail.com', 'blur-my-shell@aunetx', 'caffeine@patapon.info']"
        gsettings set org.gnome.desktop.interface clock-format '12h'
        gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
        gsettings set org.gnome.desktop.interface document-font-name 'Ubuntu 11'
        gsettings set org.gnome.desktop.interface font-antialiasing 'grayscale'
        gsettings set org.gnome.desktop.interface font-hinting 'slight'
        gsettings set org.gnome.desktop.interface font-name 'Ubuntu 11'
        gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
        gsettings set org.gnome.desktop.interface monospace-font-name 'Ubuntu Mono 10'
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
      export PS1='\[$(tput setaf 10)\]\u\[$(tput setaf 10)\]@\[$(tput setaf 10)\]\h:\w \[$(tput setaf 1)\]$(git branch 2>/dev/null | grep '"'"'*'"'"' | colrm 1 2)\[$(tput setaf 254)\]> '
      eval "$(zoxide init bash)"
      if ! { [ "$TERM" = "screen-256color" ] && [ -n "$TMUX" ]; } then
        launchtmux
      fi
	'';
  };

  programs.alacritty = {
  	enable = true;
	settings = {
  		font.normal.family = "FiraMono Nerd Font";
		font.size = 18;
		window.opacity = 0.75;
		window.decorations = "none";
        colors = { 
          primary = {
            background = "#2e3440";
            foreground = "#d8dee9";
            dim_foreground = "#a5abb6";
          };
        cursor = {
            text = "#2e3440";
            cursor = "#d8dee9";
        };
        vi_mode_cursor = {
            text = "#2e3440";
            cursor = "#d8dee9";
        };
        selection = {
            text = "CellForeground";
            background = "#4c566a";
        };
        search.matches = {
              foreground = "CellBackground";
              background = "#88c0d0";
        };
        footer_bar = {
              background = "#434c5e";
              foreground = "#d8dee9";
        }; 
        normal = {
            black = "#3b4252";
            red = "#bf616a";
            green = "#a3be8c";
            yellow = "#ebcb8b";
            blue = "#81a1c1";
            magenta = "#b48ead";
            cyan = "#88c0d0";
            white = "#e5e9f0";
        };
        bright = {
            black = "#4c566a";
            red = "#bf616a";
            green = "#a3be8c";
            yellow = "#ebcb8b";
            blue = "#81a1c1";
            magenta = "#b48ead";
            cyan = "#8fbcbb";
            white = "#eceff4";
        };
        dim = {
            black = "#373e4d";
            red = "#94545d";
            green = "#809575";
            yellow = "#b29e75";
            blue = "#68809a";
            magenta = "#8c738c";
            cyan = "#6d96a5";
            white = "#aeb3bb";
          };
        };
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
      ];
      git = true;
      enableAliases = true;
    };

  programs.zoxide = {
      enable = true;
      enableBashIntegration = true;
  };

  services.ssh-agent = {
    enable = true;
  };

}
