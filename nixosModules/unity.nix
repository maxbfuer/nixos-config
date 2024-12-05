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
    # Install with `flatpak install com.unity.UnityHub`
    flatpak.enable = true;

    environment.persistence."/nix/persist" = {
      users.max = {
        directories = [
          "Unity"
          "UnityProjects"
          ".var/app/com.unity.UnityHub"
        ];
      };
    };
  };
}
