{...}: {
  programs.git = {
    enable = true;

    userName = "Maxwell Fuerstenberg";
    userEmail = "max@maxfuerstenberg.com";

    aliases = {
      st = "status -sb";
      last = "log -1 HEAD --stat";
      cm = "commit -m";
      d = "diff";
      dc = "diff --cached";
      l = "log --pretty=format:\"%C(yellow)%h\\ %C(green)%ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]\" --decorate --date=short --graph";
      a = "add";
    };

    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
