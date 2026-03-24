{ ... }:
{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  nix.settings.auto-optimise-store = true; # automatically optimize the Nix store after garbage collection

  nix.settings.cores = 4; # set to number of CPU cores for parallel builds
  nix.settings.max-jobs = 3; # set to number of CPU cores for parallel builds

  # Prune old boot entries and generations
  boot.loader.systemd-boot.configurationLimit = 3; # keep last 3 boot entries
}
