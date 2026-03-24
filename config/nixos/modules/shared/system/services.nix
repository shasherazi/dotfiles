{ ... }:
{
  services.udisks2.enable = true;
  services.gvfs.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  services.tailscale.enable = true;

  security.rtkit.enable = true;

  programs.steam.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}
