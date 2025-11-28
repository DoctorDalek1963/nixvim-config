{
  lib,
  config,
  ...
}:
{
  config = lib.mkMerge [
    (lib.mkIf config.setup.pluginGroups.niceToHave {
      # Show diff signs in the left column and allow staging hunks with gh
      plugins.mini = {
        enable = true;
        modules.diff = {
          delay.text_change = 0;

          view = {
            style = "sign";

            signs = {
              add = "+";
              change = "~";
              delete = "-";
            };
          };
        };
      };

      # Always draw the sign column
      opts.signcolumn = "yes";
    })
    (lib.mkIf config.setup.pluginGroups.programming {
      plugins = {
        # Nicer commit editing with git
        committia.enable = true;

        # Integrate lazygit into nvim
        lazygit.enable = true;
      };

      keymaps = [
        {
          key = "<leader>lg";
          action = "<cmd>LazyGitCurrentFile<cr>";
          mode = "n";
          options.desc = "Open LazyGit for the git repo of the current file";
        }
      ];
    })
  ];
}
