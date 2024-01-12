{ config, pkgs, ... }:

{

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

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

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.flatpak.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

  };

  users.users.matt = {
    isNormalUser = true;
    description = "Matt Miller";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
      direnv
      git
    ];
  };

  nixpkgs.config.allowUnfree = true;

  nix.settings.allowed-users = [
	"matt"
  ];

  services.postgresql = {
    enable = true;
    ensureDatabases = [ "meal" ];
    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser  auth-method
      # ipv4
      local all      all    trust
      host  all      all     127.0.0.1/32   trust
    '';
    };

  system.stateVersion = "23.11";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

}

