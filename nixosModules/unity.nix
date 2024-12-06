{
  lib,
  config,
  ...
}: {
  options = {
    unity.enable = lib.mkEnableOption "install unity game development tools, including JetBrains Rider";
  };

  config = lib.mkIf config.unity.enable {
    # I could not get native nix unityhub to successfully launch the editor,
    # so I am using the flatpak version of Unity Hub.
    # VSCode was also misbehaving, so I will just try the flatpak setup.
    # Install these packages with `flatpak install ...`:
    # com.unity.UnityHub
    # com.visualstudio.code

    flatpak.enable = true;

    environment.persistence."/nix/persist" = {
      users.max = {
        directories = [
          "Unity"
          "UnityProjects"
        ];
      };
    };
  };
}
