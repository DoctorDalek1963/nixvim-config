{
  flake.nixvimModules.transparent = {
    plugins.transparent = {
      enable = true;
      settings = {
        extra_groups = [ "NormalFloat" ];
        exclude_groups = [ "CursorLine" ];
      };
    };

    globals.transparent_enabled = true;
  };
}
