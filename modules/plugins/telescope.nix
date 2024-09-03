{
  plugins = {
    telescope.enable = true;
  };

  keymaps = [
    # Open workspace symbols with Telescope
    {
      key = "<leader>ts";
      action = "<cmd>Telescope lsp_workspace_symbols<cr>";
      mode = "n";
    }
    # Open diagnostics with Telescope
    {
      key = "<leader>td";
      action = "<cmd>Telescope diagnostics<cr>";
      mode = "n";
    }
    # Open fd with Telescope
    {
      key = "<leader>tf";
      action = "<cmd>Telescope fd<cr>";
      mode = "n";
    }
  ];
}
