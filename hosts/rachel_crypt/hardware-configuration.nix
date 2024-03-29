# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/profiles/qemu-guest.nix")
    ];


  boot.initrd.availableKernelModules = [ "ahci" "xhci_pci" "virtio_pci" "sr_mod" "virtio_blk" ];
  boot.initrd.kernelModules = [ 
    "dm-snapshot" 
    "dm-raid"
    "dm-cache-default"
  ];

  # systemd boot
  boot.initrd.systemd.enable = true;

  # LUKS
  boot.initrd.luks.devices = {
    nixcryptlvm = {
    	device = "/dev/disk/by-uuid/c8c7f2b5-0588-45ff-bac6-3f986263a7d5";
	preLVM = true;
    };
  };
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { 
      # device = "/dev/disk/by-uuid/ae9d2802-4411-4d6e-a408-138a767584cd";
      device = "/dev/nix_vol/nix_root";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/25F6-6B06";
      fsType = "vfat";
    };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  networking.interfaces.enp1s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  services.lvm.boot.thin.enable = true;
}
