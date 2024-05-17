{pkgs, ...}: {
  # This can be used to enable wayland in chromium and electron (vscodium):
  # environment.sessionVariables.NIXOS_OZONE_WL = "1";
  # My first attempt caused horrible blurryness in chromium (but not vscodium), so it's Xwayland for now.
  # Perhaps the rounded windows are causing this? I suspect dwl is partially at fault.

  # auto-updated list of chromium commandLineArgs:
  # https://peter.sh/experiments/chromium-command-line-switches/
  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium;
  };

  home.sessionVariables = {
    BROWSER = "chromium";
  };
}
