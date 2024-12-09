# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
      
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Bootloader.
  # boot.loader.systemd-boot.enable = true;
  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      devices = ["nodev"];
      efiSupport = true;
      useOSProber = true;
    };
  };

  # User accounts
  users.users.cody = {
    isNormalUser = true;
    description = "Cody Weaver";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # utilities
    wget
    pciutils
    gnome-terminal
    nerdfonts
    lm_sensors
    zsh
    oh-my-posh
    cyme      
  
    # apps
    firefox-wayland
    spotify
  
    # coding tools
    vscode
    android-studio
    git
    vim

    # Gnome extensions
    gnome-tweaks
    gnomeExtensions.blur-my-shell
    gnomeExtensions.dynamic-panel
    gnomeExtensions.tiling-shell
  ];

  time.hardwareClockInLocalTime = true;

  networking.hostName = "nixos"; 

  hardware.enableAllFirmware = true;

  # Enable networking
  networking.networkmanager.enable = true;
  networking.wireless.iwd.enable = true;
  networking.networkmanager.wifi.backend = "iwd";
  
  # Enable bluetooth
  services.blueman.enable = true; 
  hardware.bluetooth = {
    package = pkgs.bluez5-experimental;
    enable = true;
    settings = {
      General = {
        Name = "NIXOS";
        Enable = "Source,Sink,Media,Socket";
        ControllerMode = "dual";
        FastConnectable = "true";
        Experimental = "true";
        KernelExperimental = "true";
      };
      Policy = {
        AutoEnable = "true";
      };
    };
    powerOnBoot = true;
  };
        

  # Set your time zone.
  time.timeZone = "America/Denver";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver = {
    enable = true;
    videoDrivers = ["nvidia"];
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
  };

  # Enable the GNOME Desktop Environment.
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
  
  # Nvidia settings

  # Enable CUDA binary cache
  nix.settings = {
    substituters = [
      "https://cuda-maintainers.cachix.org"
    ];
    trusted-public-keys = [
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
    ];
  };

  hardware.graphics = {
    enable = true;
  };
  
  hardware.nvidia = {
    
    # required
    modesetting.enable = true;
    
    # enable if sleep problems exist
    powerManagement.enable = true;
    
    # experimental
    powerManagement.finegrained = false;
    
    open = false;
    
    nvidiaSettings = true;
    
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  system.stateVersion = "24.11"; # Don't change
}
