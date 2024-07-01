{
  lib,
  config,
  ...
}: {
  options = {
    audio.enable = lib.mkEnableOption "enables audio with pipewire";
  };

  config = lib.mkIf config.audio.enable {
    # enable sound with pipewire
    sound.enable = true;
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      # support alsa, pulseaudio, and jack through pipewire
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
