{ inputs, outputs, lib, config, pkgs, ... }:
{

  home.username = "matt";
  home.homeDirectory = "/home/matt";

  home.stateVersion = "23.11";

  nixpkgs.config = {
    allowUnfree = true;
  };

  home.packages = [

      #cli
      pkgs.bash
      pkgs.bat
      pkgs.just
      pkgs.fastfetch
      pkgs.bottom
      pkgs.eza
      pkgs.git
      pkgs.gitui
      pkgs.alacritty
      pkgs.tldr
      pkgs.tmux
      pkgs.zoxide
      pkgs.fzf

      #fonts
      pkgs.ubuntu_font_family
      (pkgs.nerdfonts.override { fonts = [ "UbuntuMono"]; })

      #tools
      pkgs.keepassxc
      pkgs.brave
      pkgs.ripgrep
      pkgs.difftastic

      #social
      pkgs.libsForQt5.tokodon
      pkgs.freetube
      pkgs.obs-studio

      #code
      pkgs.python3 # what is this needed for?
      pkgs.gcc # required for Treesitter

      #ui
      pkgs.papirus-icon-theme

      (pkgs.writeShellScriptBin "launchtmux" ''
        tmux has-session -t "nixmux"
        if [ $? != 0 ]; then
          tmux new-session -d -s "nixmux" -n nvim
          tmux new-window -n gitui -t nixmux
        fi
        tmux attach
        '')

  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    NIXPKGS_ALLOW_UNFREE=1;
    SSH_ASKPASS_REQUIRE="prefer";
  };

  programs.home-manager.enable = true;

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
  		font.normal.family = "Source Code Pro";
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
