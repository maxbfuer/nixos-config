{
  lib,
  config,
  ...
}: {
  options = {
    kde.enable = lib.mkEnableOption "enables KDE desktop environment";
  };

  config = lib.mkIf config.kde.enable {
    # most files sourced from https://github.com/shalva97/kde-configuration-files
    environment.persistence."/nix/persist" = {
      users.max = {
        directories = [
          ".config/gtk-3.0"
          ".config/gtk-4.0"
          ".local/share/kservices5/searchproviders/"
          ".local/share/plasma-systemmonitor/"
        ];
        files = [
          ".config/baloofilerc"
          ".config/bluedevilglobalrc"
          ".config/breezerc"
          ".config/device_automounter_kcmrc"
          ".config/dolphinrc"
          ".config/gtkrc"
          ".config/gtkrc-2.0"
          ".config/kaccessrc"
          ".config/kactivitymanagerd-pluginsrc"
          ".config/kactivitymanagerdrc"
          ".config/kactivitymanagerd-statsrc"
          ".config/kactivitymanagerd-switcher"
          ".config/kcmfonts"
          ".config/kcminputrc"
          ".config/kdeconnect"
          ".config/kded5rc"
          ".config/kded_device_automounterrc"
          ".config/kdeglobals"
          ".config/kfontinstuirc"
          ".config/kgammarc"
          ".config/kglobalshortcutsrc"
          ".config/khotkeysrc"
          ".config/klaunchrc"
          ".config/krunnerrc"
          ".config/kscreenlockerrc"
          ".config/ksmserverrc"
          ".config/ksplashrc"
          ".config/ktimezonedrc"
          ".config/kuriikwsfiltersrc"
          ".config/kwinrc"
          ".config/kwinrulesrc"
          ".config/kxkbrc"
          ".config/mimeapps.list"
          ".config/plasma-localerc"
          ".config/plasmanotifyrc"
          ".config/plasma-org.kde.plasma.desktop-appletsrc"
          ".config/plasmarc"
          ".config/PlasmaUserFeedback"
          ".config/powermanagementprofilesrc"
          ".config/Trolltech.conf"
          ".config/user-dirs.dirs"
          ".local/share/user-places.xbel"
        ];
      };
    };

    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    services.desktopManager.plasma6.enable = true;
  };
}
