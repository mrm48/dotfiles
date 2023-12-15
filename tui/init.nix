{ inputs, outputs, lib, config, pkgs, ... }:
{


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

      pkgs.ripgrep
      pkgs.difftastic

      (pkgs.writeShellScriptBin "launchtmux" ''
        tmux has-session -t "nixmux"
        if [ $? != 0 ]; then
          tmux new-session -d -s "nixmux" -n nvim
          tmux new-window -n gitui -t nixmux
        fi
        tmux attach
        '')

  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    NIXPKGS_ALLOW_UNFREE=1;
    # SSH_ASKPASS_REQUIRE="prefer";
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
