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
