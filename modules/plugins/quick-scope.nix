{pkgs, ...}: {
  extraPlugins = [pkgs.vimPlugins.quick-scope];
  globals.qs_highlight_on_keys = ["f" "F" "t" "T"];
}
