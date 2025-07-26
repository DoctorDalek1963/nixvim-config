{
  lib,
  config,
  ...
}:
{
  config = lib.mkIf config.setup.pluginGroups.niceToHave {
    plugins.undotree.enable = true;

    keymaps = [
      {
        key = "<leader>u";
        action = "<cmd>UndotreeToggle<cr>";
        mode = "n";
        options.desc = "Toggle undotree";
      }
    ];
  };
}
