# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../modules/nvidia.nix 
    ];

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  security.polkit.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-e7e0d04a-32c6-46bd-a7f1-e40c4479ddc6".device = "/dev/disk/by-uuid/e7e0d04a-32c6-46bd-a7f1-e40c4479ddc6";
  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "usbhid" "sd_mod" "hid_generic" "hid_asus" ];
  networking.hostName = "trinsic";

  users.users.matt.extraGroups = [ "libvirtd" ];

}
