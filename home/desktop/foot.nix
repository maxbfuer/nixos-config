{...}: {
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "MesloLGS NF:size=12";
      };
    };
  };

  home.sessionVariables = {
    TERMINAL = "foot";
  };
}
