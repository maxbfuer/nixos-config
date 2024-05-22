{pkgs, ...}: {
  home.packages = with pkgs; [
    ffmpeg-full
  ];

  programs = {
    yt-dlp = {
      enable = true;
      settings = {
        # 2024-05-22: my tests have shown that using --concurrent-fragments or aria2c slows down youtube downloads
        remux-video = "mkv";
        sub-langs = "all";
        embed-subs = true;
        embed-thumbnail = true;
        embed-metadata = true;
        embed-chapters = true;
        embed-info-json = true;
        xattrs = true;

        # -X,--get-audio: audio-only alias (will not convert audio codec)
        alias = "get-audio,-X '-x --remux-video=mka'";
      };
    };
  };
}
