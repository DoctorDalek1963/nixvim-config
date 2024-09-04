{
  plugins = {
    # Nicer commit editing with git
    committia.enable = true;

    # Show diff signs in the left column
    gitgutter.enable = true;

    # Integrate lazygit into nvim
    lazygit.enable = true;
  };

  keymaps = [
    # Open LazyGit for the git repo of the current file
    {
      key = "<leader>lg";
      action = "<cmd>LazyGitCurrentFile<cr>";
      mode = "n";
    }
  ];
}
