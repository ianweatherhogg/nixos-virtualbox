{ config, pkgs, ... }:

{

  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";

  programs = {
    zsh.enable = true;
    ssh.startAgent = false;
  };

  security.sudo.enable = true;

  i18n = {
    consoleFont = "lat9w-16";
    consoleKeyMap = "uk";
    defaultLocale = "en_GB.UTF-8";
  };
  time.timeZone = "Europe/London";

  networking = {
    hostName = "nixos";
  };

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      corefonts  # Micrsoft free fonts
      inconsolata  # monospaced
      ubuntu_font_family  # Ubuntu fonts
      dejavu_fonts
      vistafonts
      ttf_bitstream_vera
      liberation_ttf
      dejavu_fonts
      terminus_font
    ];
  };

  nix = {
    # maxJobs = 1; # repeated in hardware-configuration.nix
    package = pkgs.nixUnstable;
    useChroot = true;
  };

  nixpkgs.config = {
    allowUnfree = true;
    rxvt_unicode = {
      perlBindings = true;
    };
    # firefox = {
    #   enableAdobeFlash = true;
    #   jre = false;
    # };
  };

  services.xserver = {
    autorun = true;
    displayManager.slim = {
      defaultUser = "ian";
      enable = true;
      theme = pkgs.fetchurl {
        url = https://github.com/jagajaga/nixos-slim-theme/archive/1.0.tar.gz;
        sha256 = "08ygjn5vhn3iavh36pdcb15ij3z34qnxp20xh3s1hy2hrp63s6kn";
      };
    };
    displayManager.sessionCommands = ''
       xmodmap -e 'pointer = 3 2 1 5 4 7 6 8 9 10 11 12'
       /run/current-system/sw/bin/urxvtd -q -o -f
    '';
    desktopManager = {
      xterm.enable = false;
      default = "none";
    };
    enable = true;
    layout = "gb";
#    startGnuPGAgent = true;
    windowManager = {
     i3.enable = true;
     default = "i3";
    };
  };

  services.cron.enable = false;
  services.openssh.enable = true;

  # environment.variables = {
  #   NIX_PATH = pkgs.lib.mkOverride 0 [
  #     "nixpkgs=/home/ian/.nix-defexpr/channels/nixpkgs"
  #     "nixos=/home/ian/.nix-defexpr/channels/nixpkgs/nixos"
  #     "nixos-config=/etc/nixos/configuration.nix"
  #   ];
  # };

  environment.systemPackages = with pkgs; [
    git
    # manpages
    # posix_man_pages
    xlibs.xmodmap
    xclip
    xsel
    tree
    rlwrap
    i3
    rxvt_unicode
    # emacs
    # # emacsPackages.org
    # texLiveFull
    # darcs
    # scala
  ];

  users.defaultUserShell = "/run/current-system/sw/bin/zsh";

  users.extraUsers.ian = {
    name = "ian";
    group = "users";
    uid = 1000;
    createHome = true;
    home = "/home/ian";
    useDefaultShell = true;
    openssh.authorizedKeys.keys =  [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDJmP8WhDeMd6mnn22pdlq6l8O19JOPs2p+umWhK+bCTAc7cMjkKXzXuTzcTP0pG3PgAxneNr5zqOnFTLts1WDCdbfgA7IPEAl2VqNnJHlTNNuLG3gZ57xuy5187EXb5wtUM9KicGDzA8iwm1WdjIDDVbQ2TTpx/Ifcyo/J/FP8QnsCbbhxRCb997QLsPmdAMUwYCCq/i556iTwO8Ykv8rK1yGGTAjabJ3rGRBojvA6DJBmmVHTMcUgGOKazZS3azqlhqf0gX4lKTJj9EYLlAnImY+hWd0tfwANlFJ5xN6m+MH9JwUsCatJgYxG5Qf1n1t8sgtUvg5wZiVOvRprO8iLGQUcFjK5Bgd0DerjZEzueMcvbfvtbjkA6CC4MjDOQ/Qb9n8e4ScRQ0UPW1YGtD/z1v+Sep+dLOaQZ3yhtxD+UhW/5/Fpuu0IIlnOvHGIVG/XiuqMvaZvZhjC9ZcrQ7a6vS4lFvd6arF+hb1b8gucMm7yq+/G94zPY1SOdrxgoC/9v7vkHIzVY3jjRlNl9qlHohCSQe37dfbkkGzwZv3e3jtjuTe4XrMcDVXvl20rHIadOR5BkNPHFJPQwThcIyufKn71GPSU8NDYpzLTFo9evXsntTojuUODLyVNlv6kQtwwjjSxP1eW7BpeL+qPqWaymn94PrbZWKvzEiG7cYsmgw== ian@ianweatherhogg.com" ];
    description = "Ian Weatherhogg";
    password = "ian";
    extraGroups = [
      "wheel"
      "audio"
      "vboxsf"
    ];
  };
}
