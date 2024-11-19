{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    librewolf.enable = lib.mkEnableOption "install librewolf browser";
  };

  config = lib.mkIf config.librewolf.enable {
    environment.persistence."/nix/persist" = {
      users.max = {
        directories = [
          ".librewolf"
          ".cache/librewolf"
          ".pki/nssdb"
        ];
      };
    };

    environment.systemPackages = with pkgs; [
      librewolf
    ];

    # set librewolf as default browser
    environment.sessionVariables = {
      BROWSER = "librewolf";
    };
    xdg.mime.defaultApplications = {
      "text/html" = "librewolf.desktop";
      "text/xml" = "librewolf.desktop";
      "text/json" = "librewolf.desktop";
      "text/javascript" = "librewolf.desktop";
      "application/xhtml+xml" = "librewolf.desktop";
      "application/xml" = "librewolf.desktop";
      "application/json" = "librewolf.desktop";
      "application/javascript" = "librewolf.desktop";
      "application/x-web-app-manifest+json" = "librewolf.desktop";
      "x-scheme-handler/http" = "librewolf.desktop";
      "x-scheme-handler/https" = "librewolf.desktop";
      "x-scheme-handler/ftp" = "librewolf.desktop";
      "x-scheme-handler/about" = "librewolf.desktop";
      "x-scheme-handler/unknown" = "librewolf.desktop";
      "x-scheme-handler/view-source" = "librewolf.desktop";
      "x-scheme-handler/data" = "librewolf.desktop";
    };
  };
}
