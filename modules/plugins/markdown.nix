{
  lib,
  config,
  ...
}:
{
  config = lib.mkIf config.setup.pluginGroups.niceToHave {
    # Preview markdown files in the browser
    plugins.markdown-preview.enable = true;
  };
}
