{
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.setup.pluginGroups.base {
    extraPlugins = [pkgs.vimPlugins.quick-scope];
    globals.qs_highlight_on_keys = ["f" "F" "t" "T"];
  };
}
