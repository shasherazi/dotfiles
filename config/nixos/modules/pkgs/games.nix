{pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    mindustry-wayland
  ];
}
