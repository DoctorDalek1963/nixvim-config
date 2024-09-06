{
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.setup.pluginGroups.programming {
    assertions = [
      {
        assertion = config.plugins.telescope.enable;
        message = "actions-preview requires telescope";
      }
    ];

    extraPlugins = [pkgs.vimPlugins.actions-preview-nvim];

    keymaps = [
      {
        key = "<M-return>";
        action.__raw = "require('actions-preview').code_actions";
        mode = "n";
        options = {
          silent = true;
          desc = "Open code actions with preview";
        };
      }
    ];

    extraConfigLua =
      # lua
      ''
        require("actions-preview").setup {
          highlight_command = {
            require("actions-preview.highlight").delta("${pkgs.delta}/bin/delta --no-gitconfig --side-by-side")
          },
          telescope = vim.tbl_extend(
            "force",
            require("telescope.themes").get_dropdown(),
            {
              layout_config = {
                center = {
                  height = 0.2,
                  width = 0.8
                }
              }
            }
          ),
        }
      '';
  };
}
