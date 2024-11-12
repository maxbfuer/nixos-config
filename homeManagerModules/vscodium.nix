{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    vscodium.enable = lib.mkEnableOption "install and configure vscodium";
  };

  config = lib.mkIf config.vscodium.enable {
    # TODO: currently leaving .config/VSCodium in system/persist.nix
    # I was having issues getting HM impermanence and User/settings.json to work
    home.persistence."/nix/persist/home/max" = {
      directories = [
        "repos"
      ];
    };

    home.packages = with pkgs; [
      nixd # nix LSP
      alejandra # nix formatter
      shellcheck # shell script linter
      shfmt

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
        # shell
        timonwong.shellcheck
        foxundermoon.shell-format
      ];

      userSettings = {
        "extensions.experimental.affinity" = {
          "asvetliakov.vscode-neovim" = 1;
        };
        "keyboard.dispatch" = "keyCode"; # makes caps/escape remap work with vscode-neovim
        "editor.formatOnSave" = true;
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nixd";
        # "nix.serverSettings.nixd.formatting.command" = ["alejandra"];
        "nix.serverSettings" = {
          "nixd" = {
            "formatting" = {
              "command" = ["alejandra"];
            };
            "options" = {
              "nixos" = {
                "expr" = "(builtins.getFlake ./.).nixosConfigurations.gaia.options";
              };
              "home-manager" = {
                "expr" = "(builtins.getFlake \"github:msfjarvis/dotfiles\").homeConfigurations.\"msfjarvis@ryzenbox\".options";
              };
            };
          };
        };
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
            body = [
              "#[test]"
              "fn $1() {"
              "\t$2"
              "}"
            ];
          };
        };
        shellscript = {
          dash = {
            prefix = ["dash"];
            description = "Insert a dash shebang";
            body = ["#!/usr/bin/env dash\n\n"];
          };
          param_1 = {
            prefix = ["param_1"];
            description = "Take one parameter, erroring if it is not given";
            body = [
              ''if [ "$#" -ne 1 ]; then''
              ("\t" + ''echo "Usage: $(basename "\$0") <$1>" >&2'')
              ("\t" + ''exit 1'')
              ''fi''
              ''$1="\$1"''
            ];
          };
          err = {
            prefix = ["err"];
            description = "Echo into stderr";
            body = [
              ''echo $1 >&2''
            ];
          };
        };
        nix = {
          nixmod = {
            prefix = ["nixmod"];
            description = "Template for a nixos or home-manager toggleable config module";
            body = [
              ''
                {
                  lib,
                  config,
                  $1
                  ...
                }: {
                  options = {
                    $2.enable = lib.mkEnableOption "$3";
                  };

                  config = lib.mkIf config.$2.enable {
                    $4
                  };
                }
              ''
            ];
          };
        };
      };
    };
  };
}
