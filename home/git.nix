{...}: {
  programs.git = {
    enable = true;
    userName = "Maxwell Fuerstenberg";
    userEmail = "max@maxfuerstenberg.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
