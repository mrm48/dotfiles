# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{

  # Enable the Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.flatpak.enable = true;

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  security.polkit.enable = true;

  environment.systemPackages = with pkgs; [
    spice-gtk
    hyprland
  ];

  programs.hyprland.enable = true;

  virtualisation.spiceUSBRedirection.enable = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # GPU
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages = with pkgs; [
    amdvlk
  ];
  hardware.opengl.extraPackages32 = with pkgs; [
    driversi686Linux.amdvlk
  ];

  services.xserver.videoDrivers = [ "amdgpu" ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sdb";
  boot.loader.grub.useOSProber = true;
  boot.initrd.kernelModules = [ "amdgpu" ];

  networking.hostName = "ankh"; # Define your hostname.

  users.users.matt.extraGroups = [ "libvirtd" ];

}
