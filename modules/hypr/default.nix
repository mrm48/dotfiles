
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

      general = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
  
        gaps_in = 5;
        gaps_out = 5;
        border_size = 2;
        "col.active_border" = "rgba(ea6962ee) rgba(ea6962ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
  
        layout = "master";
  
        # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
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
        new_is_master = true;
      };
  
      gestures = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        workspace_swipe = "off";
      };
  
      "$mainMod" = "ALT";
      "$superMod" = "SUPERALT";
      "$shiftMod" = "SHIFTALT";
  
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

}
