{ config, pkgs, ... }:

{

  imports =
    [
    <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  boot.initrd.availableKernelModules = [ "ata_piix" "ohci_pci" "ehci_pci" ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
     { device = "/dev/sda1";
        fsType = "ext4";
     };

  services.virtualbox.enable = true;

}
