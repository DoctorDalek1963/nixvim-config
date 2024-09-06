{pkgs, ...}: {
  plugins = {
    telescope.enable = true;
  };

  extraPackages = [pkgs.fd];

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
  ];
}
