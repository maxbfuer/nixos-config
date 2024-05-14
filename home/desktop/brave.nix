{...}: {
  programs.brave = {
    enable = true;
    extensions = [
      {id = "nngceckbapebfimnlniiiahkandclblb";}
    ];
  };

  home.sessionVariables = {
    BROWSER = "brave";
  };
}
