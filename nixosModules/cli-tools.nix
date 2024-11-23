{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    cli-tools.enable = lib.mkEnableOption "installs an assortment of CLI tools";
  };

  config = lib.mkIf config.cli-tools.enable {
    environment.systemPackages = with pkgs; [
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
      nmap # port scanner / network mapper
      dash # very fast narrowly POSIX-compliant shell
      fd # modern find alternative
      ripgrep # improved grep
      eza # modern ls alternative
      fzf # fuzzy finder
      hyperfine # benchmarking tool
      jq # JSON processor
      viddy # modern watch replacement
      tokei # project code counter
      unzip # unzip zip archives
      whois # query WHOIS database
    ];
  };
}
