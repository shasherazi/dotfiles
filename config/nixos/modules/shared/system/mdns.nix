{ ... }:
{
  # Avahi = the mDNS responder/announcer
  services.avahi = {
    enable = true;

    # Integrate with NSS so `.local` names resolve via mDNS
    nssmdns4 = true; # IPv4 mDNS (most common)
    nssmdns6 = true; # IPv6 mDNS (optional, usually fine)

    # Allow mDNS traffic (UDP 5353) through the firewall
    openFirewall = true;

    publish = {
      enable = true;
      addresses = true;
      workstation = true;
      userServices = true;
    };
  };
}
