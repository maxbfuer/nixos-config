{pkgs, ...}: {
  home.packages = with pkgs; [
    nil # nix LSP
    alejandra # nix formatter
    rustup # manages the rust toolchain
    gcc # used by rust
  ];

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;

    extensions = with pkgs.vscode-extensions; [
      # general
      asvetliakov.vscode-neovim
      # nix
      jnoortheen.nix-ide
      # rust
      rust-lang.rust-analyzer
      vadimcn.vscode-lldb
      tamasfe.even-better-toml
      # docker
      ms-azuretools.vscode-docker
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
      "nix.serverSettings.nil.nix.maxMemoryMB" = 8192; # give nil more memory, the default was failing
      "nix.serverSettings.nil.nix.flake.autoArchive" = true; # automatically save local copies of flake inputs
      "nix.serverSettings.nil.nix.flake.autoEvalInputs" = true; # improve completion at the cost of time/memory
      "rust-analyzer.check.command" = "clippy";
      "editor.snippetSuggestions" = "top";
      "editor.fontFamily" = "MonaspiceNe Nerd Font";
      "editor.fontSize" = 16;
      "terminal.integrated.fontFamily" = "MesloLGS NF";
    };

    languageSnippets = {
      rust = {
        test = {
          prefix = ["test"];
          description = "Insert a test function";
          body = ["#[test]" "fn $1() {" "    $2" "}"];
        };
      };
    };
  };
}
