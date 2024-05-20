{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    docker-compose
  ];

  users.users.max.extraGroups = ["docker" "mediaserver"];

  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = false;
      # setSocketVariable = true;
    };
  };

  users.groups.mediaserver = {
    gid = 780;
  };
  users.users.mediaserver = {
    isSystemUser = true;
    uid = 780;
    group = "mediaserver";
  };
}
