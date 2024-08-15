{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    nom.enable = lib.mkEnableOption "enables nix-output-monitor with aliases";
  };

  config = lib.mkIf config.nix-gc.enable {
    environment.systemPackages = with pkgs; [
      nix-output-monitor
    ];

    programs.zsh.shellAliases = {
      nors = "doas nixos-rebuild switch --option eval-cache false --flake 'path:/home/max/repos/nixos-config#gaia' --log-format internal-json -v |& nom --json";
      nfu = "nix flake update --log-format internal-json -v |& nom --json";
    };
  };
}
