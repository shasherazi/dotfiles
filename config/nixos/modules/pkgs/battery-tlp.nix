{ ... }:
{
  services.tlp = {
    enable = true;

    settings = {
      # Battery charge thresholds (e.g., stop charging at 80%, start at 40%)
      START_CHARGE_THRESH_BAT0 = 40; # Start charging when battery drops to this percentage
      STOP_CHARGE_THRESH_BAT0 = 80; # Stop charging when it reaches this percentage
    };
  };

  services.power-profiles-daemon.enable = false;
}
