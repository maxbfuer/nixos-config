{pkgs, ...}: {
  programs.mpv = {
    enable = true;
    config = {
      profile = "gpu-hq";
      force-window = true;
      cache = true;
      demuxer-max-bytes = "512MiB";
      demuxer-max-back-bytes = "256MiB";
      save-position-on-quit = true;
    };
    scripts = with pkgs.mpvScripts; [
      mpv-playlistmanager
    ];
  };
}
