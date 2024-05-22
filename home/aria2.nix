{...}: {
  programs.aria2 = {
    # configure aria2c for maximum download speeds
    enable = true;
    settings = {
      # the number of pieces to split an item into and download simultaneously
      split = 16;
      max-connection-per-server = 16;
      # the maximum number of concurrent items/files
      max-concurrent-downloads = 32;
      http-accept-gzip = true;

      # fastest on modern filesystems like xfs
      file-allocation = "falloc";
      # cache more data in memory before writing to disk,
      # writes happen in larger blocks reducing disk I/O
      disk-cache = "128M";
      # theoretically improves performance
      enable-mmap = true;

      max-tries = 10;
      retry-wait = 5;

      # appear as windows chrome
      user-agent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36";
    };
  };
}
