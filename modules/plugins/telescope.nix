{
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.setup.pluginGroups.niceToHave {
    plugins.telescope = {
      enable = true;
      extensions.fzf-native.enable = true;
    };

    keymaps = [
      {
        key = "<leader>ts";
        action = "<cmd>Telescope lsp_workspace_symbols<cr>";
        mode = "n";
        options.desc = "Open workspace symbols with Telescope";
      }
      {
        key = "<leader>td";
        action = "<cmd>Telescope diagnostics<cr>";
        mode = "n";
        options.desc = "Open diagnostics with Telescope";
      }
      {
        key = "<leader>tf";
        action = "<cmd>Telescope fd<cr>";
        mode = "n";
        options.desc = "Open fd with Telescope";
      }
      {
        key = "<leader>tg";
        action = "<cmd>Telescope live_grep<cr>";
        mode = "n";
        options.desc = "Open ripgrep with Telescope";
      }
    ];
  };
}
