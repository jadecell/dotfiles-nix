#9aa92 Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];


  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];


  fileSystems."/" =
    { device = "/dev/disk/by-label/NIXROOT";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-label/NIXBOOT";
      fsType = "vfat";
    };

  fileSystems."/home/jackson/Media" = {
    device = "/dev/disk/by-uuid/48fcb030-45da-4b60-9036-bb335ba9aa92";
    fsType = "ext4";
    options = [ "user" "rw" ];
  };

  swapDevices = [ ];

  networking.hostName = "orion";

  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";

}
