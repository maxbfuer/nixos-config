{
  lib,
  config,
  ...
}: {
  options = {
    unfree.enable = lib.mkEnableOption "enables unfree packages";
  };

  config = lib.mkIf config.unfree.enable {
    # allow unfree for specific packages
    nixpkgs.config.allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [
        "obsidian"
        "zsh-abbr"
        "unityhub"
      ];
  };
}
