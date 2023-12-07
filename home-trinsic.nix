{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "matt";
  home.homeDirectory = "/home/matt";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  nixpkgs.config = {
    allowUnfree = true;
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [

      #cli
      pkgs.bash
      pkgs.bat
      pkgs.just
      pkgs.fastfetch
      pkgs.bottom
      pkgs.eza
      pkgs.git
      pkgs.alacritty

      #fonts
      pkgs.ubuntu_font_family
      (pkgs.nerdfonts.override { fonts = [ "UbuntuMono"]; })

      #tools
      pkgs.keepassxc
      pkgs.libsForQt5.ksshaskpass
      pkgs.brave
      pkgs.librewolf
      pkgs.logseq

      #social
      pkgs.libsForQt5.tokodon
      pkgs.freetube
      pkgs.obs-studio
      pkgs.thunderbird

      #code
      pkgs.python3
      pkgs.jdk19
      pkgs.neovim
      pkgs.maven

      #games
      pkgs.steam

      #ui
      pkgs.papirus-icon-theme

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
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

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/matt/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    NIXPKGS_ALLOW_UNFREE=1;
    SSH_ASKPASS="/home/matt/.nix-profile/bin/ksshaskpass";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.neovim = {
    plugins = [
      {
        plugin = pkgs.vimPlugins.nvim-jdtls;
      }
    ];
  };

  programs.git = {
    enable = true;
    userName = "Matt Miller";
    userEmail = "mmiller@crispyecho.com";

  };

  programs.bash = {
    enable = true;
    shellAliases = {
      eza = "eza -lar --icons";
      codetree = "eza -lr --tree --icons";
    };
    bashrcExtra = ''
	export PS1='\[$(tput setaf 10)\]\u\[$(tput setaf 10)\]@\[$(tput setaf 10)\]\h:\w \[$(tput setaf 1)\]$(git branch 2>/dev/null | grep '"'"'*'"'"' | colrm 1 2)\[$(tput setaf 254)\]> '
	'';
  };

  programs.alacritty = {
  	enable = true;
	settings = {
  		font.normal.family = "UbuntuMono NerdFont Mono"; 
		font.size = 16;
		window.opacity = 0.75;
		window.decorations = "none";
		};
  };
}
