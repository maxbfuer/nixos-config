{pkgs, ...}: {
  # dwl binding: very fast, simple dmenu/rofi for wlroots
  programs.tofi = {
    enable = true;
    settings = {
      # specifying the font file improves startup time
      # see: https://github.com/philj56/tofi?tab=readme-ov-file#performance
      font = "${pkgs.monaspace}/share/fonts/opentype/MonaspaceNeon-Regular.otf";
      fuzzy-match = true;
      prompt-text = "\"> \"";
      # "fullscreen" theme
      width = "100%";
      height = "100%";
      border-width = 0;
      outline-width = 0;
      padding-left = "40%";
      padding-top = "10%";
      result-spacing = 25;
      num-results = 15;
      background-color = "#000A";
    };
  };
}
