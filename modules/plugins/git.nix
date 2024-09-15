{
  lib,
  config,
  ...
}:
{
  config = lib.mkMerge [
    (lib.mkIf config.setup.pluginGroups.niceToHave {
      # Show diff signs in the left column
      plugins.gitgutter.enable = true;

      opts = {
        # Faster updates make gitgutter work better
        updatetime = 100;

        # Always draw the sign column
        signcolumn = "yes";
      };
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
