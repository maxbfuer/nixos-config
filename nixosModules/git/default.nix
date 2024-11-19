{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    git.enable = lib.mkEnableOption "install git with config, credentials, and aliases";
  };

  config = lib.mkIf config.git.enable {
    environment.systemPackages = with pkgs; [
      git
    ];

    system.userActivationScripts.createGitConf = ''
      install -Dm 444 ${./gitconfig} ~/.config/git/config
    '';
  };
}
