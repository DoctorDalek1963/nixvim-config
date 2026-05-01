{
  lib,
  config,
  ...
}:
{
  config = lib.mkIf config.setup.pluginGroups.base {
    plugins.yanky = {
      enable = true;
      enableTelescope = config.plugins.telescope.enable;
    };

    keymaps = [
      {
        key = "p";
        action = "<Plug>(YankyPutAfter)";
        mode = [
          "n"
          "x"
        ];
        options.desc = "Yanky put after";
      }
      {
        key = "P";
        action = "<Plug>(YankyPutBefore)";
        mode = [
          "n"
          "x"
        ];
        options.desc = "Yanky put before";
      }
      {
        key = "gp";
        action = "<Plug>(YankyGPutAfter)";
        mode = [
          "n"
          "x"
        ];
        options.desc = "Yanky g put after";
      }
      {
        key = "gP";
        action = "<Plug>(YankyGPutBefore)";
        mode = [
          "n"
          "x"
        ];
        options.desc = "Yanky g put before";
      }
      {
        key = "<C-p>";
        action = "<Plug>(YankyPreviousEntry)";
        mode = "n";
        options.desc = "Yanky previous ring entry";
      }
      {
        key = "<C-n>";
        action = "<Plug>(YankyNextEntry)";
        mode = "n";
        options.desc = "Yanky next ring entry";
      }
    ]
    ++ (lib.optional config.plugins.telescope.enable {
      key = "<leader>ty";
      action = "<cmd>Telescope yank_history<cr>";
      mode = "n";
      options.desc = "Open Yanky ring with Telescope";
    });
  };
}
