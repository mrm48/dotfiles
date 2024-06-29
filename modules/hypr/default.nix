
{ config, pkgs, ... }:

{

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {

      env = [ "XCURSOR_SIZE,24" ];

      input = {
          kb_layout = "us";
          kb_variant = "";
          kb_model = "";
          kb_options = ctrl:nocaps;
          kb_rules = "";
      
          follow_mouse = 0;
      
          touchpad = {
              natural_scroll = "no";
          };
      
          sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
      };

      monitor = [
        "DP-1,1920x1080@144,0x0,1"
        "HDMI-A-1,1920x1080@60, 1920x0, 1"
      ];

      workspace = [
        "1, monitor:DP-1"
        "2, monitor:DP-1"
        "3, monitor:DP-1"
        "4, monitor:DP-1"
        "5, monitor:DP-1"
        "6, monitor:HDMI-A-1"
        "7, monitor:HDMI-A-1"
        "8, monitor:HDMI-A-1"
        "9, monitor:HDMI-A-1"
        "0, monitor:HDMI-A-1"
      ];

      exec-once = [ "waybar" "nm-applet" ];

      general = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
  
        gaps_in = 5;
        gaps_out = 5;
        border_size = 2;
        "col.active_border" = "rgba(ea6962ee) rgba(ea6962ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
  
        # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        layout = "master";
        allow_tearing = false;
      };
      decoration = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
  
        rounding = 0; # default 10
        
        blur = {
            enabled = true;
            size = 3;
            passes = 1;
        };
  
        drop_shadow = "yes";
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
      };
      animations = {
        enabled = "yes";
  
        # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
  
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
  
        animation = [ "windows, 1, 7, myBezier"
                      "windowsOut, 1, 7, default, popin 80%"
                      "border, 1, 10, default"
                      "borderangle, 1, 8, default"
                      "fade, 1, 7, default"
                      "workspaces, 1, 6, default"
                    ];
      };
        
      dwindle = {
        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        pseudotile = "yes";  # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below;
        preserve_split = "yes";  # you probably want this;
      };
  
      master = {
        # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
        new_status = "master";
      };
  
      gestures = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        workspace_swipe = "off";
      };
  
      "$mainMod" = "SUPER";
      "$superMod" = "ALTSUPER";
      "$shiftMod" = "SHIFTSUPER";
      "$ctrlMod"  = "CTRLSUPER";
  
      bind = [
        "$mainMod, RETURN, exec, alacritty"
        "$mainMod, W, killactive"
        "$shiftMod, M, exit"
        "$mainMod, E, exec, nautilus"
        "$mainMod, V, togglefloating"
        "$mainMod, R, exec, wofi --normal-window --show drun"
        "$mainMod, P, pseudo"
        "$mainMod, C, togglesplit"
        "$mainMod, H, movefocus, l"
        "$mainMod, L, movefocus, r"
        "$mainMod, K, movefocus, u"
        "$mainMod, J, movefocus, d"
        "$shiftMod, H, movewindow, l"
        "$shiftMod, L, movewindow, r"
        "$shiftMod, K, movewindow, u"
        "$shiftMod, J, movewindow, d"
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
        "$ctrlMod, L, exec, hyprlock"
      ];

      bindm = [    
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };

  home.packages = with pkgs; [

    #hyprland utilities
    wofi
    hyprpaper
    xdg-desktop-portal-hyprland
    kdePackages.qtwayland
    grim
    slurp
    jq
    pavucontrol
    wlsunset

  ];

  programs.wofi = {
    enable = true;
    style = ''

      window {
        margin: 0px;
        border: 1px solid #928374;
        background-color: #282828;
      }
      
      #input {
        margin: 5px;
        border: none;
        color: #ebdbb2;
        background-color: #1d2021;
      }
      
      #inner-box {
        margin: 5px;
        border: none;
        background-color: #282828;
      }
      
      #outer-box {
        margin: 5px;
        border: none;
        background-color: #282828;
      }
      
      #scroll {
        margin: 0px;
        border: none;
      }
      
      #text {
        margin: 5px;
        border: none;
        color: #ebdbb2;
      }
      
      #entry:selected {
        background-color: #1d2021;
      }

      '';
  };

  programs.waybar.enable = true;  
  programs.waybar.settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        output = [ "DP-1" "HDMI-A-1" ];
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [ "battery" "wireplumber" "tray" ];
        clock = {
          interval = 60;
          format = "{:%a %b %d %OI:%M %p}";
          max-length = 25;
        };
      };
    };

  services.hyprpaper.enable = true;
  services.hyprpaper.settings = {
      splash = false;
      splash_offset = 2.0;

      preload = [ "/home/matt/Pictures/walls/wolf.jpg" ];

      wallpaper = [
        "DP-1,/home/matt/Pictures/walls/wolf.jpg"
        "HDMI-A-1,/home/matt/Pictures/walls/wolf.jpg"
      ];
        

    };

  programs.hyprlock.enable = true;
  programs.hyprlock.settings = {
      general = {
        disable_loading_bar = true;
        grace = 300;
        hide_cursor = true;
        no_fade_in = false;
      };

      background = [
        {
          path = "screenshot";
          blur_passes = 3;
          blur_size = 8;
        }
      ];

      input-field = [
        {
          size = "200, 50";
          position = "0, -80";
          monitor = "";
          dots_center = true;
          fade_on_empty = false;
          font_color = "rgb(202, 211, 245)";
          inner_color = "rgb(91, 96, 120)";
          outer_color = "rgb(24, 25, 38)";
          font_family = "Ubuntu";
          placeholder_text = "Enter password...";
          outline_thickness = 5;
          shadow_passes = 2;
        }
      ];

      label = [
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$(date +"%-I:%M%p")"'';
          color = "$foreground";
          font_size = 60;
          font_family = "Ubuntu";
          position = "0, -300";
          halign = "center";
          valign = "top";
        }
      ];
  };

}
