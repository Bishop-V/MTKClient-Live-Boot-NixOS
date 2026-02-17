{ config, pkgs, ... }:

{

  home = {
    username = "mtkclient";
    homeDirectory = "/home/mtkclient";
    stateVersion = "25.11";
  };

  
  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "dash-to-dock@micxgx.gmail.com"
      ];
    };
    
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";        
      gtk-theme    = "Adwaita-dark"; 
      icon-theme   = "Adwaita";      
    };

    "org/gnome/shell/extensions/dash-to-dock" = {
      dock-position = "BOTTOM";        
      dock-fixed = true;             
      autohide = false;
      intellihide = false;
      click-action = "minimize";   
      show-trace = false;
      multi-monitor = true;          
      isolate-workspaces = true;  
    };
  };
}

