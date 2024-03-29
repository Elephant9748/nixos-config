{ config, pkgs, lib, unstable, inputs, vars,  ... }:
{
  # imports = ( import ../modules/editors );

  # Set your time zone.
  time.timeZone = "Asia/Jakarta";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
    useXkbConfig = false; # use xkbOptions in tty.
  };


  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  users = { 
   users.${vars.user} = {
      isNormalUser = true;
      home = "/home/${vars.user}";
      extraGroups = [ "wheel" "sudo" "networkmanager" ]; # Enable ‘sudo’ for the user.
      # openssh.authorizedkeys.keys [ "" ];
   };
   defaultUserShell = pkgs.fish;
  };

  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    neovim
    home-manager
    gnupg
    vim
    wget
    git
    fish
    curl
    fastfetch
    neofetch
    cmake
    gnumake
    unzip
    gettext
    ninja
    lsb-release
    unzip
    zip
    tree
    gcc 
    libgcc
    libclang
    nodejs
    python312
    pciutils
    procps
    eza
    meson

    # plymouth nicer full disk unlock at boot
    # plymouth
  ];

  #nix = {
  #  package = pkgs.nix;
  #  settings.experimental-features = [ "nix-command" "flakes" ];
  #};

  nix = {
      settings = {
          auto-optimise-store = true;
      };
      gc = {
          automatic = true;
	  dates = "weekly";
	  options = "--delete-older-than 3d";
      };
      package = pkgs.nixVersions.unstable;
      registry.nixpkgs.flake = inputs.nixpkgs-unstable;
      extraOptions = ''
          experimental-features = nix-command flakes
	      keep-outputs		= true
	      keep-derivations	= true
      '';
  };

  nixpkgs.config.allowUnfree = true; # proprietary software.

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
	enable = true;
	settings = {
	    Port = "44";
	    PermitRootLogin = "no";
	    MaxAuthTries = "3";
	    PubkeyAuthentication = false;
	    AuthorizedKeysFile = ".ssh/authorized_keys";
	    PasswordAuthentication = true;
	    AllowTcpForwarding = false;
	    GatewayPorts = "no";
	    X11Forwarding = false;

	    #? nixos
	    #Subsystem = "sftp  internal-sftp";
	};
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "${vars.version}"; # Did you read the comment?

  # home-manager.users.${user} = { pkgs, ... }: {
  #   home.packages = with pkgs; [ htop powertop ];
  #   home.stateVersion = "${version}";
  # };

}
