{pkgs, ...}: {
  home.packages = with pkgs; [
    hueadm
  ];

  home.file.".hueadm.json" = {
    text = ''
      {
          "user": "-qHlpWnWjXt0SsI4x8lETFNTxEMznpEIhiyQJHC8",
          "host": "192.168.0.107"
      }
    '';
  };
}
