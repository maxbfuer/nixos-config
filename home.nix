{
  config,
  pkgs,
  ...
}: {
  home.username = "max";
  home.homeDirectory = "/home/max";

  home.packages = with pkgs; [
    nil # nix LSP, used by vscodium
    alejandra # nix formatter, used by vscodium
  ];

  programs.git = {
    enable = true;
    userName = "Maxwell Fuerstenberg";
    userEmail = "max@maxfuerstenberg.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      asvetliakov.vscode-neovim
      jnoortheen.nix-ide
    ];
    userSettings = {
      "extensions.experimental.affinity" = {
        "asvetliakov.vscode-neovim" = 1;
      };
      "keyboard.dispatch" = "keyCode"; # makes caps/escape remap work with vscode-neovim
      "editor.formatOnSave" = true;
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nil";
      "nix.serverSettings.nil.formatting.command" = ["alejandra"];
      "nix.serverSettings.nil.nix.flake.maxMemoryMB" = 4096; # give nil more memory, the default was failing
      "nix.serverSettings.nil.nix.flake.autoArchive" = true; # automatically save local copies of flake inputs
      "nix.serverSettings.nil.nix.flake.autoEvalInputs" = true; # improve completion at the cost of time/memory
    };
  };

  programs.brave = {
    enable = true;
    extensions = [
      {id = "nngceckbapebfimnlniiiahkandclblb";}
    ];
  };

  home.sessionVariables = {
    BROWSER = "brave";
  };

  # home manager will install and manage itself
  programs.home-manager.enable = true;

  home.stateVersion = "23.11";
}
