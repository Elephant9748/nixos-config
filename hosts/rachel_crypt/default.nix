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
     	enable = true;
	configurationLimit = 5;
   	efiSupport = true;
	device = "nodev";
	
	# For disk encryption
	enableCryptodisk = true;

     };

     timeout = 3;
  };

  # plymouth boot
  # boot.plymouth = {
  #    enable = true;
  #    #theme = "bgrt";
  #    theme = "cuts";
  #    themePackages = [(pkgs.adi1090x-plymouth-themes.override {selected_themes = ["cuts"];})];
  # };

  # Linux Kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # kernel parameters
  boot.kernelParams = ["quiet"];
  #boot.kernelParams = ["plymouth.enable=1"];

  # initrd.kernelModules = [ "" ]; # Add kernel modules --> hardware-configuration.nix

  # error mdadm: Neither MAILADDR nor PROGRAM has been set.
  boot.swraid.enable = false;

  networking.hostName = "Nixos-Phoebe"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # programs
  programs = { 
        # hyprland
        hyprland = {
            enable = true;
            # nvidiaPatches = true;
            xwayland.enable = true;
        };

        # Gnome
        dconf.enable = true;
  };

  # xdg.portal.enable = true;
  # xdg.portal.extraPortals = [ 
  #       pkgs.xdg-desktop-portal-hyprland
  # ];

  environment.sessionVariables = {
      # If your cursor becomes invisible
      WLR_NO_HARDWARE_CURSORS = "1";
      # Hint electron apps to use wayland
      NIXOS_OZONE_WL = "1";
  };

  hardware = {
      # Opengl
      # opengl = { 
      #   enable = true; 
      #   extraPackages = with pkgs; [
      #       intel-media-driver
      #       vaapiIntel
      #       vaapiVdpau
      #       libvdpau-va-gl
      #   ];
      # };
      # Most wayland compositors need this
      # nvidia.modesetting.enable = true;
      pulseaudio.enable = false;
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
       vulkan-tools
       glxinfo
       mesa
       kitty
    ];
  };

  # Gnome
  services.xserver = {
        enable = true;
        desktopManager.gnome = {
            enable = true;
        };
        displayManager.gdm = {
            enable = true;
            wayland = true;
        };
  };

  # pipewire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

}
