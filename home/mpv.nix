{pkgs, ...}: {
  programs.mpv = {
    enable = true;
    config = {
      profile = "gpu-hq";
      hwdec = "auto";
      force-window = true;
      save-position-on-quit = true;
      cache = true;
      demuxer-max-bytes = "512MiB";
      demuxer-max-back-bytes = "256MiB";
      # select english audio and subs, but with subs hidden by default
      alang = "eng,en";
      slang = "eng,en";
      sub-visibility = false;
    };
    # scripts = with pkgs.mpvScripts; [
    #   mpv-playlistmanager
    # ];
  };
}
