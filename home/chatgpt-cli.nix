{
  inputs,
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    chatgpt-cli
  ];
  # config.age.secrets.openai_api_key.file = ../secrets/openai_api_key.age;
  # hom = config.age.secrets.openai_api_key.path;
}
