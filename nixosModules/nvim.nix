{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    nvim.enable = lib.mkEnableOption "enables neovim";
  };

  config = lib.mkIf config.nvim.enable {
    environment.systemPackages = with pkgs; [
      neovim
    ];

    environment.variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };
}
