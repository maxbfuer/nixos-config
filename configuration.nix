{
  config,
  pkgs,
  options,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "gaia";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";

  # enable X and KDE Plasma
  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver = {
    layout = "us";
    xkbOptions = "caps:escape";
  };

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
    extraGroups = ["networkmanager" "wheel"];
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];
  environment.systemPackages = with pkgs; [
    git
    neovim

    pciutils # lspci
    usbutils # lsusb
    dmidecode # reads hardware information from the BIOS
    strace # system call tracer
    ltrace # library call tracer
    lsof # list open files
    lm_sensors # read hardware sensors

    atop # detailed performance monitor
    nvtop-amd # GPU monitor
    btop # pretty process monitor

    fd # modern find alternative
    ripgrep # improved grep
    eza # modern ls alternative
    fzf # fuzzer finder

    zsh-powerlevel10k # zsh prompt
    meslo-lgs-nf # Meslo Nerd Font for powerlevel10k
  ];
  environment.variables.EDITOR = "nvim";
  environment.variables.VISUAL = "nvim";

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

  system.stateVersion = "23.11";
}
