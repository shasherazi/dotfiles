{ ... }:
{
  security.sudo.enable = true;
  security.sudo.extraRules = [
    {
      users = [ "shasherazi" ];
      commands = [
        {
          # needed for the waybar script to switch performance profiles
          command = "/run/current-system/sw/bin/tee /sys/firmware/acpi/platform_profile";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];
}
