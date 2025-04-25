{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  boot.initrd.kernelModules = [ "i2c_hid"];
  # System & Bootloader
  # system.stateVersion = "24.11"; # Did you read the comment?
  boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelModules = [ "i915" ];
  boot.kernelParams = [
    "i915.enable_guc=3"
    "i915.force_probe=7d45"
    #"acpi_osi=Linux"
    #"acpi_backlight=vendor"
    #"i8042.nopnp=1"
    #"i8042.dumbkbd=1"
  ];

  # Hardware & Firmware
  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;
  
  # Intel Graphics
  services.xserver.videoDrivers = [ "modesetting" ];
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      mesa.drivers
      intel-media-driver
      intel-compute-runtime
      vaapiIntel
      vaapiVdpau
      vulkan-loader
      vulkan-tools
    ];
  };
  
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };
  
  # TrackPoint configuration
  hardware.trackpoint = {
    enable = true;
    emulateWheel = true;
    sensitivity = 100;
    speed = 100;
  };

  # Networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # networking.firewall.enable = false;

  # Localization & Time
  time.timeZone = "Australia/Sydney";
  i18n.defaultLocale = "en_AU.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  # X11 & Desktop Environment
  services.xserver = {
    enable = true;
    xkb = {
      layout = "au";
      variant = "";
    };
    displayManager.lightdm.enable = false;
    windowManager.bspwm.enable = true;
    
    # Touchpad configuration using libinput
    libinput = {
      enable = true;
      touchpad = {
        tapping = true;
        naturalScrolling = true;
        disableWhileTyping = true;
        clickMethod = "clickfinger";
      };
    };
  };
  
  services.displayManager.ly.enable = true;
  services.pipewire.enable = true;

  # Security
  security.sudo.extraConfig = ''
    jordanm ALL=(ALL) NOPASSWD: /run/current-system/sw/bin/physlock
  '';

  # Environment
  environment.extraInit = ''
    export PATH="$HOME/.local/bin:$PATH"
  '';
  
  nixpkgs.config.allowUnfree = true;

  # User Configuration
  users.users.jordanm = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "jordan maquiran";
    extraGroups = [ "networkmanager" "wheel" "audio" "input" "video" ];
    packages = with pkgs; [];
  };

  # Shell & Editors
  programs.zsh.enable = true;
  programs.zsh.ohMyZsh.enable = true;
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  # Fonts
  fonts.packages = with pkgs; [
    nerdfonts
    termsyn
    texlivePackages.fontawesome
    noto-fonts
    material-icons
  ];

  # System Packages
  environment.systemPackages = with pkgs; [
    # Editors
    neovim
    
    # Window Manager & Desktop
    bspwm
    sxhkd
    alacritty
    picom
    xterm
    feh
    rofi
    eww
    polybarFull
    
    # Web & Media
    firefox
    fastfetch
    gwenview
    youtube-music
    playerctl
    xdotool
    pulseaudio
    
    # Eww dependencies
    cairo
    gtk3
    gdk-pixbuf
    librsvg
    pango
    
    # Screenshots & Media Utils
    ffcast
    slop
    xclip
    
    # Development Tools
    xorg.xev
    git
    lazygit
    gnumake
    unzip
    gzip
    pkgs.brightnessctl
    libinput

    # Display Manager
    physlock
    
    # Graphics
    vulkan-tools
    glxinfo
    
    # CLI Utilities
    bottom
    lf
    tree
    wget
    ripgrep
    
    # Programming Languages & LSP
    nil
    sumneko-lua-language-server
    clang
    python3
    nodejs
    
    # Networking
    iw
  ];

  # Additional Services
  # services.openssh.enable = true;
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
}
