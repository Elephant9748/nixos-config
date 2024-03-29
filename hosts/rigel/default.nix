{ inputs, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # GRUB
  boot.loader = {
     efi = {
	canTouchEfiVariables = true;
	efiSysMountPoint = "/boot";
     };
     grub = {
	configurationLimit = 5;
   	efiSupport = true;
	device = "nodev";
	
	# For disk encryption
	enableCryptodisk = true;

     };

     timeout = 1;
  };

  # Linux Kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # initrd.kernelModules = [ "" ]; # Add kernel modules --> hardware-configuration.nix

  # error mdadm: Neither MAILADDR nor PROGRAM has been set.
  boot.swraid.enable = false;

  networking.hostName = "nixos-io"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # packages 
  environment = {
    systemPackages = with pkgs; [
        glances
    ];
  };

}
