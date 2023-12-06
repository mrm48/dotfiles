# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/778f8862-e52b-4f63-85a3-94c931838c4c";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-5dcf5825-23d9-4e73-81f4-a3e601b3eef3".device = "/dev/disk/by-uuid/5dcf5825-23d9-4e73-81f4-a3e601b3eef3";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/08BD-6CE0";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/fdb971be-b085-44ab-af3e-5619bfc8443e"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp3s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
