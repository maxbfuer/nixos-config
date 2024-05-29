{...}: {
  home.persistence."/nix/persist/home/max" = {
    defaultDirectoryMethod = "symlink";
  };
}
