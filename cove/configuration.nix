# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-418a3e08-4da0-4118-8195-46374dfc2eaa".device = "/dev/disk/by-uuid/418a3e08-4da0-4118-8195-46374dfc2eaa";
  boot.kernelPackages = pkgs.linuxPackages_latest;
  networking.hostName = "cove";

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.flatpak.enable = true;

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  security.polkit.enable = true;

  environment.systemPackages = with pkgs; [
    spice-gtk
    hyprland
    hyprlock
  ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # GPU
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
  hardware.graphics.extraPackages = with pkgs; [
    amdvlk
  ];
  hardware.graphics.extraPackages32 = with pkgs; [
    driversi686Linux.amdvlk
  ];

  services.xserver.videoDrivers = [ "amdgpu" ];

  # Bootloader.
  boot.initrd.kernelModules = [ "amdgpu" ];
  virtualisation.spiceUSBRedirection.enable = true;

  users.users.matt.extraGroups = [ "libvirtd" ];
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
