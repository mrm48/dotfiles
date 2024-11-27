{ config, pkgs, ... }:

{

  home.packages = with pkgs; [

    #gnome extensions
    pkgs.gnome-tweaks
    pkgs.dconf-editor
    chrome-gnome-shell
    gnomeExtensions.appindicator
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
      gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left "['<Shift><Super>h']"
      gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right "['<Shift><Super>l']"
      gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['<Super>h']"
      gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<Super>l']"
      gsettings set org.gnome.desktop.wm.keybindings move-to-monitor-left "['<Ctrl><Super>h']"
      gsettings set org.gnome.desktop.wm.keybindings move-to-monitor-right "['<Ctrl><Super>l']"
      gsettings set org.gnome.desktop.wm.keybindings maximize "['<Super>g']"
      gsettings set org.gnome.desktop.input-sources xkb-options "['terminate:ctrl_alt_bksp', 'caps:ctrl_modifier', 'ctrl:nocaps']"
      gsettings set org.gnome.shell disabled-extensions "['dash-to-panel@jderose9.github.com']"
      gsettings set org.gnome.shell enabled-extensions "['dash-to-dock@micxgx.gmail.com', 'blur-my-shell@aunetx', 'caffeine@patapon.info']"
      gsettings set org.gnome.desktop.interface clock-format '12h'
      gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
      gsettings set org.gnome.desktop.interface font-antialiasing 'grayscale'
      gsettings set org.gnome.desktop.interface font-hinting 'slight'
      gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
    '')
  ];

}
