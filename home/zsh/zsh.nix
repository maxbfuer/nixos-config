{pkgs, ...}: {
  # FIXME: I'm not sure that .zcompdump is working, I touched it but it's staying empty right now
  home.persistence."/nix/persist/home/max" = {
    files = [
      ".zsh_history"
      ".zcompdump"
    ];
  };

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

      cdtemp = ''cd $(mktemp -d)'';
    };

    zsh-abbr = {
      enable = true;
      abbreviations = {
        # general
        d = "doas";
        v = "nvim";
        vr = "nvim -RM";
        g = "git";
        c = "cargo";

        # docker
        dlo = "docker logs";
        dps = "docker ps";
        dim = "docker images";
        dprune = "docker system prune -af --volumes";

        dc = "docker-compose";
        dcu = "docker-compose up -d";
        dcd = "docker-compose down";
        dcre = "docker-compose restart";
        dcpu = "docker-compose pull";
        dcex = "docker-compose exec";
        dclo = "docker-compose logs";
        dcps = "docker-compose ps";
        dcco = "docker-compose config";
      };
    };

    # autostart dwl when logging in on tty1
    profileExtra = ''
      [ "''${TTY}" = '/dev/tty1' ] && exec dbus-run-session dwl -s set_wallpapers
    '';
  };
}
