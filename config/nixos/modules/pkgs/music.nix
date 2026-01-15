{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    mpc
    nicotine-plus
    puddletag
    rmpc
  ];

  services.mpd = {
    enable = true;
    user = "shasherazi";

    settings = {
      music_directory = "/home/shasherazi/Music";
      playlist_directory = "/home/shasherazi/.config/mpd/playlists";
      db_file = "/home/shasherazi/.config/mpd/database";
      log_file = "/home/shasherazi/.cache/mpd/log";
      bind_to_address = "localhost";
      port = 6600;
      auto_update = true;
      audio_output = [
        {
          type = "pulse";
          name = "PulseAudio Output (via PipeWire)";
          server = "/run/user/1000/pulse/native";
        }
      ];
    };
  };

  systemd.services.mpd.serviceConfig = {
    ExecStartPre = [
      # Make sure directory exists
      "${pkgs.coreutils}/bin/mkdir -p /home/shasherazi/.cache/mpd"

      # Make sure file exists
      "${pkgs.coreutils}/bin/touch /home/shasherazi/.cache/mpd/log"
    ];
  };
}
