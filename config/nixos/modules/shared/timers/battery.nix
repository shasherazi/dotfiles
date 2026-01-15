{ pkgs, ... }:
let
  batteryCheckScript = pkgs.writeShellApplication {
    name = "battery-check";
    runtimeInputs = with pkgs; [
      acpi
      gnugrep
      dunst
    ];
    text = ''
      #!/usr/bin/env bash

      battery_level=$(acpi -b | grep -P -o '[0-9]+(?=%)')
      discharging=$(acpi -b | grep -P -o 'Discharging')

      if [ "$battery_level" -ge 80 ] && [ -z "$discharging" ]; then
          dunstify -u critical -r 1122 "Battery almost full. Unplug the charger for longer battery life." "Battery level is $battery_level%!"
      fi

      if [ "$battery_level" -le 30 ] && [ "$discharging" ]; then
          dunstify -u critical -r 1122 "Charge your battery" "Battery level is $battery_level%!"
      fi
    '';
  };
in
{
  systemd.user.services.battery-check = {
    description = "Battery level check service";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${batteryCheckScript}/bin/battery-check";
    };
  };

  systemd.user.timers.battery-check = {
    description = "Run battery check every 5 minutes";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "*:0/5";
      Persistent = true;
    };
  };
}
