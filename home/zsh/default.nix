{pkgs, ...}: {
  home.packages = with pkgs; [
    zsh-powerlevel10k # prompt
  ];

  programs.zsh = {
    enable = true;

    dotDir = ".config/zsh";
    history.size = 10000000;
    initExtra = ''
      setopt AUTO_CD AUTO_PUSHD
    '';

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = ./p10k-config;
        file = "p10k.zsh";
      }
    ];

    shellAliases = {
      # ls/eza
      ls = "eza";
      lsa = "eza -a";
      ll = "eza -l --group";
      lla = "eza -la --group";
      tree = "eza -T";
      treea = "eza -Ta";
      treel = "eza -Tl --group";
      treela = "eza -Tla --group";
    };

    zsh-abbr = {
      enable = true;
      abbreviations = {
        g = "git";
        nors = "doas nixos-rebuild switch --option eval-cache false --flake \"path:$(realpath /etc/nixos)#gaia\"";
        nfu = "nix flake update";
      };
    };

    # autostart dwl when logging in on tty1
    profileExtra = ''
      [ "''${TTY}" = '/dev/tty1' ] && exec dbus-run-session dwl -s waybar
    '';
  };
}
