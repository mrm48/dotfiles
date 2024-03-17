{ config, pkgs, ... }:

{

  home.packages = with pkgs; [

    #gnome extensions
    gnome.gnome-tweaks
    gnome.dconf-editor
    chrome-gnome-shell
    gnomeExtensions.blur-my-shell
    gnomeExtensions.dash-to-dock
    gnomeExtensions.dash-to-panel
    gnomeExtensions.caffeine
    gnomeExtensions.logo-menu

    (writeShellScriptBin "setup-favorites" ''
      # Set up favorites for gnome convert this to an autostart script
      gsettings set org.gnome.shell favorite-apps "['Alacritty.desktop', 'librewolf.desktop', 'org.kde.kate.desktop', 'logseq.desktop', 'thunderbird.desktop', 'freetube.desktop' ]"
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

}
