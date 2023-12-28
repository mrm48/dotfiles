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
    #extraConfig = {
    #  core = {
    #  };
    #};
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
  		font.normal.family = "UbuntuMono Nerd Font Mono";
		font.size = 18;
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
      set -g status-right "#[fg=black]%d %b %Y %l:%M %p"
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
