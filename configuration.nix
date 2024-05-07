{
  config,
  pkgs,
  options,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./vfio.nix
    ./nix.nix
  ];

  boot.loader = {
    systemd-boot = {
      enable = true;
      consoleMode = "2"; # increase boot menu resolution
    };
    efi.canTouchEfiVariables = true;
  };

  networking.hostName = "gaia";
  networking.wireless.iwd.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";

  hardware.opengl.enable = true;
  services.displayManager.enable = false;
  # services.xserver.xkb = {
  #   layout = "us";
  #   options = "caps:escape";
  # };

  # enable sound with pipewire
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # define the user account
  users.users.max = {
    isNormalUser = true;
    description = "Max";
    extraGroups = ["networkmanager" "wheel" "docker"];
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];
  environment.systemPackages = with pkgs; [
    git
    neovim
    docker-compose
    moonlight-qt

    # -- system monitoring --
    btop # pretty process monitor
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

    # -- CLI/scripting --
    fd # modern find alternative
    ripgrep # improved grep
    eza # modern ls alternative
    fzf # fuzzy finder
    hyperfine # benchmarking tool
    jq # JSON processor
    bat # cat with syntax highlighting, git integration, and more

    # -- shell --
    zsh-powerlevel10k # zsh prompt

    # -- desktop --
    freetube # YouTube client
    xclip # clipboard
    qbittorrent # bittorrent client
  ];
  fonts = {
    packages = with pkgs; [
      meslo-lgs-nf # terminal font; recommended for p10k (zsh prompt)
      monaspace # code font
      ubuntu_font_family # dwl font
      # Noto for language and emoji coverage
      noto-fonts
      noto-fonts-cjk
      noto-fonts-color-emoji
      noto-fonts-monochrome-emoji
    ];

    fontconfig = {
      subpixel.rgba = "rgb";
      defaultFonts = {
        monospace = ["Noto Sans Mono"];
        serif = ["Noto Serif"];
        sansSerif = ["Noto Sans"];
        emoji = ["Noto Color Emoji" "Noto Emoji"];
      };
    };
  };
  programs.zsh = {
    enable = true;
    histSize = 10000000;
    promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    setOptions = [
      "AUTO_CD"
      "AUTO_PUSHD"
    ];
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
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

  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn; # include CLI and GUI
  };

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  system.stateVersion = "23.11";
}
