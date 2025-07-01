{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
let
  iosevka-aile = pkgs.iosevka-bin.override { variant = "Aile"; };
in
{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  #
  # Kernel
  # 

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ "amdgpu" ];

  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  #
  # Graphical Boot Screen
  # 

  boot.consoleLogLevel = 3;
  boot.initrd.verbose = false;
  boot.initrd.systemd.enable = true;
  boot.kernelParams = [
    "quiet"
    "splash"
    "intremap=on"
    "boot.shell_on_fail"
    "udev.log_priority=3"
    "rd.systemd.show_status=auto"
  ];

  boot.plymouth.enable = true;  
  boot.plymouth.font = "${iosevka-aile}/share/fonts/truetype/IosevkaAile-Medium.ttc";

  #
  # Disk Encryption & Software RAID
  # 

  boot.initrd.luks.devices =
    { "luks-pool-sda3".device = "/dev/sda3";
      "luks-pool-sdb3".device = "/dev/sdb3";
      "swap".device = "/dev/sda2";
      "swap-mirror".device = "/dev/sdb2";
    };
    
  boot.swraid =
    {
      enable = true;
      mdadmConf = ''
        MAILADDR = tim@baccaert.com
        MAILFROM = no-reply@${config.networking.hostName}
      '';
    };

  #
  # Filesystem Mountpoints
  # 

  fileSystems."/" =
    { device = "luks-pool/root";
      fsType = "zfs";
    };

  fileSystems."/home" =
    { device = "luks-pool/home";
      fsType = "zfs";
    };

  fileSystems."/nix" =
    { device = "luks-pool/nix";
      fsType = "zfs";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/444D-6534";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  fileSystems."/boot-mirror" =
    { device = "/dev/disk/by-uuid/44F6-9D24";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  swapDevices = [
    { device = "/dev/md127"; }
  ];

  #
  # Bootloader
  # 

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
    useOSProber = true;
    mirroredBoots = [
      { devices = [ "/dev/disk/by-uuid/44F6-9D24" ];
        path = "/boot-mirror";
      }
    ];
  };


  #
  # Networking
  # 

  networking.useDHCP = lib.mkDefault true;
  networking.hostId = "AFFEC7ED";

  #
  # Platform
  # 

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
