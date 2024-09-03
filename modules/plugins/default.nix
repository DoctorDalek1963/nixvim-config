{
  imports = [
    ./lualine.nix
    ./telescope.nix
    ./treesitter.nix
  ];

  plugins = {
    # Toggle comments with `gc`, `gb`, and friends
    comment.enable = true;

    # Nicer commit editing with git
    committia.enable = true;

    # Debugging
    # Show update messages in the bottom right
    fidget = {
      enable = true;
      notification = {
        filter = "info";
        overrideVimNotify = true;
      };
    };

    # Show diff signs in the left column
    gitgutter.enable = true;

    # Show indentation levels
    indent-blankline = {
      enable = true;
      settings.scope.enabled = false;
    };

    # Resume editing from the last place
    lastplace.enable = true;

    # Integrate lazygit into nvim
    lazygit.enable = true;

    # Preview markdown files in the browser
    markdown-preview.enable = true;

    # Make marks easier and nicer to use
    marks.enable = true;

    # Automatically pair brackets and quotes and things
    nvim-autopairs.enable = true;

    # Rainbow brackets and tags
    rainbow-delimiters.enable = true;

    # Improve w e b motions, basically camelCaseMotions
    spider = {
      enable = true;
      keymaps = {
        motions = {
          b = "b";
          e = "e";
          ge = "ge";
          w = "w";
        };
        silent = true;
      };
    };

    # Handle delimiters like () [] {} "" '' better
    surround.enable = true;

    # See a tree of undo history
    undotree.enable = true;

    # Make matching tags like () [] {} "" '' work better
    vim-matchup = {
      enable = true;
      matchParen.offscreen = {
        method = "popup";
        scrolloff = true;
      };
    };

    # Make yanking better. See keymaps
    yanky.enable = true;

    # Use the yazi terminal file manager
    yazi = {
      enable = true;
      settings.open_for_directories = true;
    };
  };
}
