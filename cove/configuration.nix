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

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-6a91b9e9-08e2-4ac4-87a5-df00df4e0b66".device = "/dev/disk/by-uuid/6a91b9e9-08e2-4ac4-87a5-df00df4e0b66";
  networking.hostName = "cove";

  users.users.matt.extraGroups = [ "libvirtd" ];

}
