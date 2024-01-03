{ inputs, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # GRUB
  boot.loader = {
     efi = {
	canTouchEfiVariables = true;
	efiSysMountPoint = "/boot/EFI";
     };
     grub = {
	configurationLimit = 5;
   	efiSupport = true;
	device = "nodev";
	
	# For disk encryption
	enableCryptodisk = true;

     };

     timeout = 3;
  };

  # Linux Kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # initrd.kernelModules = [ "" ]; # Add kernel modules --> hardware-configuration.nix

  # error mdadm: Neither MAILADDR nor PROGRAM has been set.
  boot.swraid.enable = false;

  networking.hostName = "Nixos-Phoebe"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # hyprland
  programs.hyprland = {
      enable = true;
      nvidiaPatches = true;
      xwayland.enable = true;
  };

  environment.sessionVariables = {
      # If your cursor becomes invisible
      WLR_NO_HARDWARE_CURSORS = "1";
      # Hint electron apps to use wayland
      NIXOS_OZONE_WL = "1";
  };

  hardware = {
      # Opengl
      opengl.enable = true;
      # Most wayland compositors need this
      nvidia.modesetting.enable = true;
  };

  xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };

  # packages 
  environment = {
    systemPackages = with pkgs; [
       grim
       slurp
       wl-clipboard
       wayland
       rofi
       waybar
    ];
  };

}
