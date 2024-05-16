{...}: {
  programs.git = {
    enable = true;

    userName = "Maxwell Fuerstenberg";
    userEmail = "max@maxfuerstenberg.com";

    aliases = {
      a = "add";
      cm = "commit -m";
      ca = "commit --amend";

      st = "status -sb";
      d = "diff";
      dc = "diff --cached";

      ls = "log --pretty=format:\"%C(yellow)%h\\ %C(green)%ad%Cred%d\\ %Creset%s%Cblue\" --decorate --date=short";
      ll = "log --pretty=format:\"%C(yellow)%h\\ %C(green)%ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]\" --decorate --date=short --stat";
      graph = "log --oneline --graph --decorate";
      last = "log -1 HEAD --stat";

      c = "clone";
      sc = "clone --depth=1";
    };

    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
