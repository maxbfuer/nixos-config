{
  inputs,
  config,
  pkgs,
  ...
}: {
  home.persistence."/nix/persist/home/max" = {
    directories = [
      ".config/chatgpt"
    ];
  };

  home.packages = with pkgs; [
    chatgpt-cli
  ];
}
