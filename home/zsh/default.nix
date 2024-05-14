{pkgs, ...}: {
  home.packages = with pkgs; [
    zsh-powerlevel10k # prompt
  ];

  programs.zsh = {
    enable = true;

    history.size = 10000000;
    enableCompletion = true;

    dotDir = ".config/zsh";

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

    # autostart dwl when logging in on tty1
    profileExtra = ''
      [ "''${TTY}" = '/dev/tty1' ] && exec dbus-run-session dwl -s waybar
    '';

    initExtra = ''
      setopt AUTO_CD AUTO_PUSHD
    '';

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
  };
}
