{
  plugins.undotree.enable = true;

  keymaps = [
    {
      key = "<leader>u";
      action = "<cmd>UndotreeToggle<cr>";
      mode = "n";
    }
  ];
}
