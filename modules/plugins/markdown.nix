{pkgs, ...}: {
  extraPlugins = [pkgs.vimPlugins.vim-pencil];

  # Preview markdown files in the browser
  plugins.markdown-preview.enable = true;

  keymaps = [
    {
      key = "<leader>g";
      action = "<cmd>SoftPencil<cr>";
      mode = "n";
      options = {
        silent = true;
        desc = "Toggle SoftPencil";
      };
    }
  ];
}
