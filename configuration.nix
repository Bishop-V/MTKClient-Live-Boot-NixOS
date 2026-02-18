{ config, pkgs,pkgs-unstable, lib, modulesPath, ... }:

{

  networking.hostName = "nixos-mtk"; 

  # Enable networking
  networking.networkmanager.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";

    
  
  services = {
    xserver = {
      enable = true;
      desktopManager = {
        xterm.enable = false;
        xfce.enable = true;
      };
    };
    displayManager.autoLogin = {
      enable = true;
      user = "mtkclient";
    };
  };
  environment.xfce.excludePackages = with pkgs.xfce; [
    #mousepad
    parole
    #ristretto
    #xfce4-appfinder
    #xfce4-notifyd
    #xfce4-screenshooter
   # xfce4-session
   # xfce4-settings
   # xfce4-taskmanager
   # xfce4-terminal 
  ];

  
  boot.loader = {
    grub = {
      enable = true;
      efiSupport = true;   
      device = "nodev";          
      timeoutStyle = "hidden";      
    };
    timeout = lib.mkForce 0;                 
  };


  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };


  users.users."mtkclient" = {
    isNormalUser = true;
    description = "mtkclient";
    extraGroups = [ "networkmanager" "wheel" ];
    password = "1234";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = 
    (with pkgs; [
      neovim 
      librewolf
    ])

    ++

    (with pkgs-unstable; [
      mtkclient
    ]);

  programs.adb.enable = true;
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.11"; 

}
