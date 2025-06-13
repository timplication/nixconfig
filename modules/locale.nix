{ config, lib, ... }:
with lib;
let
  cfg = config.tim.locale; 
in
{
  options.tim.locale = {
    dualboot = mkOption {
      description = "Enable this option if this system shares /boot/efi with windows.";
      type = types.bool;
      default = false;
    };
  };

  config = {
    # HACK: this should be enabled if we share this machine with a windows partition.
    # the reason is that the system clock may be incorrect after booting from windows
    # back into NixOS, because Windows by default uses RTC as its time standard. Hence,
    # to be compatible with windows, we enable RTC as time standard on NixOS as well.
    time.hardwareClockInLocalTime = cfg.dualboot;

    time.timeZone = "Europe/Brussels";

    i18n.defaultLocale = "en_US.UTF-8";

    # I like the Irish locale because it uses EUR and dots as a decimal separator.
    # It also uses the DD/MM/YYYY format for dates.
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_IE.UTF-8";
      LC_IDENTIFICATION = "en_IE.UTF-8";
      LC_MEASUREMENT = "en_IE.UTF-8";
      LC_MONETARY = "en_IE.UTF-8";
      LC_NAME = "en_IE.UTF-8";
      LC_NUMERIC = "en_IE.UTF-8";
      LC_PAPER = "en_IE.UTF-8";
      LC_TELEPHONE = "en_IE.UTF-8";
      LC_TIME = "en_IE.UTF-8";
    };
  };
}
