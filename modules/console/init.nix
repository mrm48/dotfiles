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
      export PS1='\[$(tput setaf 10)\]\u\[$(tput setaf 10)\]@\[$(tput setaf 10)\]\h:\w \[$(tput setaf 1)\]$(git branch 2>/dev/null | grep '"'"'*'"'"' | colrm 1 2)\[\033[00m\]> '
      eval "$(zoxide init bash)"
      if ! { [ "$TERM" = "screen-256color" ] && [ -n "$TMUX" ]; } then
        launchtmux
      fi
	'';
  };

  programs.alacritty = {
    enable = true;
    settings = {
        import = [ "~/.config/alacritty/gruvbox.yml" ];

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

  home.file.".config/alacritty/gruvbox.yml".text = ''
    # The definition of color schemes.
    schemes:
      gruvbox_material_hard_dark: &gruvbox_material_hard_dark
        primary:
          background: '0x1d2021'
          foreground: '0xd4be98'
        normal:
          black:   '0x32302f'
          red:     '0xea6962'
          green:   '0xa9b665'
          yellow:  '0xd8a657'
          blue:    '0x7daea3'
          magenta: '0xd3869b'
          cyan:    '0x89b482'
          white:   '0xd4be98'
        bright:
          black:   '0x32302f'
          red:     '0xea6962'
          green:   '0xa9b665'
          yellow:  '0xd8a657'
          blue:    '0x7daea3'
          magenta: '0xd3869b'
          cyan:    '0x89b482'
          white:   '0xd4be98'
      gruvbox_material_medium_dark: &gruvbox_material_medium_dark
        primary:
          background: '0x282828'
          foreground: '0xd4be98'
        normal:
          black:   '0x3c3836'
          red:     '0xea6962'
          green:   '0xa9b665'
          yellow:  '0xd8a657'
          blue:    '0x7daea3'
          magenta: '0xd3869b'
          cyan:    '0x89b482'
          white:   '0xd4be98'
        bright:
          black:   '0x3c3836'
          red:     '0xea6962'
          green:   '0xa9b665'
          yellow:  '0xd8a657'
          blue:    '0x7daea3'
          magenta: '0xd3869b'
          cyan:    '0x89b482'
          white:   '0xd4be98'
      gruvbox_material_soft_dark: &gruvbox_material_soft_dark
        primary:
          background: '0x32302f'
          foreground: '0xd4be98'
        normal:
          black:   '0x45403d'
          red:     '0xea6962'
          green:   '0xa9b665'
          yellow:  '0xd8a657'
          blue:    '0x7daea3'
          magenta: '0xd3869b'
          cyan:    '0x89b482'
          white:   '0xd4be98'
        bright:
          black:   '0x45403d'
          red:     '0xea6962'
          green:   '0xa9b665'
          yellow:  '0xd8a657'
          blue:    '0x7daea3'
          magenta: '0xd3869b'
          cyan:    '0x89b482'
          white:   '0xd4be98'
      gruvbox_material_hard_light: &gruvbox_material_hard_light
        primary:
          background: '0xf9f5d7'
          foreground: '0x654735'
        normal:
          black:   '0x654735'
          red:     '0xc14a4a'
          green:   '0x6c782e'
          yellow:  '0xb47109'
          blue:    '0x45707a'
          magenta: '0x945e80'
          cyan:    '0x4c7a5d'
          white:   '0xf2e5bc'
        bright:
          black:   '0x654735'
          red:     '0xc14a4a'
          green:   '0x6c782e'
          yellow:  '0xb47109'
          blue:    '0x45707a'
          magenta: '0x945e80'
          cyan:    '0x4c7a5d'
          white:   '0xf2e5bc'
      gruvbox_material_medium_light: &gruvbox_material_medium_light
        primary:
          background: '0xfbf1c7'
          foreground: '0x654735'
        normal:
          black:   '0x654735'
          red:     '0xc14a4a'
          green:   '0x6c782e'
          yellow:  '0xb47109'
          blue:    '0x45707a'
          magenta: '0x945e80'
          cyan:    '0x4c7a5d'
          white:   '0xeee0b7'
        bright:
          black:   '0x654735'
          red:     '0xc14a4a'
          green:   '0x6c782e'
          yellow:  '0xb47109'
          blue:    '0x45707a'
          magenta: '0x945e80'
          cyan:    '0x4c7a5d'
          white:   '0xeee0b7'
      gruvbox_material_soft_light: &gruvbox_material_soft_light
        primary:
          background: '0xf2e5bc'
          foreground: '0x654735'
        normal:
          black:   '0x654735'
          red:     '0xc14a4a'
          green:   '0x6c782e'
          yellow:  '0xb47109'
          blue:    '0x45707a'
          magenta: '0x945e80'
          cyan:    '0x4c7a5d'
          white:   '0xe6d5ae'
        bright:
          black:   '0x654735'
          red:     '0xc14a4a'
          green:   '0x6c782e'
          yellow:  '0xb47109'
          blue:    '0x45707a'
          magenta: '0x945e80'
          cyan:    '0x4c7a5d'
          white:   '0xe6d5ae'
    
    # Apply the color scheme.
    colors: *gruvbox_material_medium_dark
    '';
}
