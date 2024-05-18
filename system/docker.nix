{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    docker-compose
  ];

  users.users.max.extraGroups = ["docker"];

  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
}
