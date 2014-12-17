{ config, pkgs, ... }:

{

  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";

  programs.zsh.enable = true;
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

  # services = {
  #   xserver = {
  #     autorun = true;
  #     desktopManager = {
  #       slim = {
  #         defaultUser = "ian";
  #         enable = true;
  #         theme = pkgs.fetchurl {
  #           url = https://github.com/jagajaga/nixos-slim-theme/archive/1.0.tar.gz;
  #           sha256 = "08ygjn5vhn3iavh36pdcb15ij3z34qnxp20xh3s1hy2hrp63s6kn";
  #         };
  #       };#slim
  #       xterm.enable = false;
  #       default = "none";
  #       sessionCommands = "
  #          xmodmap -e 'pointer = 3 2 1 5 4 7 6 8 9 10 11 12'
  #          urxvtd -q -o -f
  #          eval $(keychain --eval --quiet)
  #       ";#TODO urxvt as systemd and no keychain
  #     };#displayManager
  #     enable = true;
  #     layout = "gb";
  #     startGnuPGAgent = true;
  #     windowManager = {
  #      i3.enable = true;
  #      default = "i3";
  #     };
  #   };#xserver
  #   cron.enable = false;
  # };#services

  environment.systemPackages = with pkgs; [
    git
    manpages
    posix_man_pages
    i3
    rxvt_unicode
    # emacs
    # emacsPackages.org
    texLiveFull
    darcs
    scala
  ];

  users.defaultUserShell = "/run/current-system/sw/bin/zsh";

  users.extraUsers.ian = {
    name = "ian";
    group = "users";
    uid = 1000;
    createHome = true;
    home = "/home/ian";
    useDefaultShell = true;
    description = "Ian Weatherhogg";
    password = "ian";
    extraGroups = [
      "wheel"
      "audio"
    ];
  };
}
