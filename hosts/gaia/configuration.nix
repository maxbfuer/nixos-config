{
  pkgs,
  options,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  audio.enable = true;
  bluetooth.enable = true;
  borg.enable = true;
  doas.enable = true;
  docker.enable = true;
  networking.enable = true;
  nom.enable = true;
  nix-gc.enable = true;
  nvim.enable = true;
  persist.enable = true;
  sshd.enable = true;
  unfree.enable = true;
  vfio.enable = true;
  kde.enable = true;
  unity.enable = true;
  android.enable = true;
  mpv.enable = true;
  yt-dlp.enable = true;
  hue.enable = true;
  aria2.enable = true;
  btop.enable = true;
  foot.enable = true;

  hardware.opengl.enable = true;

  boot.loader = {
    systemd-boot = {
      enable = true;
      consoleMode = "2"; # increase boot menu resolution
    };
    efi.canTouchEfiVariables = true;
  };

  users.mutableUsers = false;
  users.users.root.initialHashedPassword = "$y$j9T$quE96HPGIEjVX/9inly2L/$zo4v0sHkuqN.YvP7ERrM28AUvAm6BzQ.MGMHUATTC2B";

  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";
  # services.xserver.xkb = {
  #   layout = "us";
  #   options = "caps:escape";
  # };

  # define the user account
  users.users.max = {
    isNormalUser = true;
    initialHashedPassword = "$y$j9T$epaQgPhOyuk95n9x2kJ0m/$8/K9H67v7kyIPI0qW88XKsFUB5nhfOyUN1Snm4VrrsD";
    description = "Max";
    extraGroups = ["wheel"];
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];
  environment.systemPackages = with pkgs; [
    git # required for nix flakes
    moonlight-qt
    inputs.dwl-flake.packages.${system}.dwl

    # -- system monitoring --
    atop # detailed performance monitor
    nvtopPackages.amd # GPU monitor
    pciutils # lspci
    usbutils # lsusb
    dmidecode # reads hardware information from the BIOS
    strace # system call tracer
    ltrace # library call tracer
    lsof # list open files
    lm_sensors # read hardware sensors
    extrace # monitor and print exec calls
    duf # prettier `du`
    ncdu # nice interactive disk usage analyzer
    nmap

    # -- CLI/scripting --
    dash # very fast narrowly POSIX-compliant shell
    fd # modern find alternative
    ripgrep # improved grep
    eza # modern ls alternative
    fzf # fuzzy finder
    hyperfine # benchmarking tool
    jq # JSON processor
    viddy # modern watch replacement

    # -- desktop --
    xclip # clipboard
    qbittorrent # bittorrent client
  ];
  fonts = {
    packages = with pkgs; [
      meslo-lgs-nf # terminal font; recommended for p10k (zsh prompt)
      monaspace # code font
      # Noto for language and emoji coverage
      noto-fonts
      noto-fonts-cjk
      noto-fonts-color-emoji
      noto-fonts-monochrome-emoji

      (nerdfonts.override {fonts = ["Monaspace" "Ubuntu"];})
    ];

    fontconfig = {
      subpixel.rgba = "rgb";
      # TODO: is this necessary? should I have nerd fonts in here?
      defaultFonts = {
        monospace = ["Noto Sans Mono"];
        serif = ["Noto Serif"];
        sansSerif = ["Noto Sans"];
        emoji = ["Noto Color Emoji" "Noto Emoji"];
      };
    };
  };

  # home-manager needs these to configure zsh
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  programs.fzf.keybindings = true; # use fzf/zsh integration

  # plocate: super-fast file finder
  services.locate = {
    enable = true;
    package = pkgs.plocate;
    localuser = null; # plocate will only run as root, setting this to null silences a warning
    interval = "hourly";
    prunePaths = options.services.locate.prunePaths.default ++ ["/mnt/storage"];
  };

  services.fstrim.enable = true;

  services.minidlna = {
    enable = true;
    settings.media_dir = ["/mnt/storage/mediaserver/data"];
  };
  networking.firewall.enable = false;

  system.stateVersion = "23.11";
}
