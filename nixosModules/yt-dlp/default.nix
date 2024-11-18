{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    yt-dlp.enable = lib.mkEnableOption "installs and configures yt-dlp";
  };

  config = lib.mkIf config.yt-dlp.enable {
    environment.systemPackages = with pkgs; [
      ffmpeg-full
      yt-dlp
    ];

    system.userActivationScripts.createYtDlpConf = ''
      install -Dm 444 ${./config} ~/.config/yt-dlp/config
    '';
  };
}
