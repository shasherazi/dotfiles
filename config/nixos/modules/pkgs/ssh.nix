{ ... }:
{
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;

      # Optional hardening
      X11Forwarding = false;
    };
  };

  networking.firewall.allowedTCPPorts = [ 22 ];

  # Allow shtinkbook to SSH into user shasherazi
  users.users.shasherazi.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICYif6UohbY1eCjpso9MS6FsEI7O9/EXWtid0bBizAyn hassanrandomz@gmail.com"
  ];
}
