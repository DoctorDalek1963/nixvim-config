{
  imports = [
    ./lsp

    ./git.nix
    ./lualine.nix
    ./telescope.nix
    ./treesitter.nix
    ./ufo.nix
    ./yanky.nix
    ./yazi.nix
  ];

  plugins = {
    # Toggle comments with `gc`, `gb`, and friends
    comment.enable = true;

    # Debugging
    # Show update messages in the bottom right
    fidget = {
      enable = true;
      notification = {
        filter = "info";
        overrideVimNotify = true;
      };
    };

    # Show indentation levels
    indent-blankline = {
      enable = true;
      settings.scope.enabled = false;
    };

    # Resume editing from the last place
    lastplace.enable = true;

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

    # Make matching tags like () [] {} "" '' work better
    vim-matchup = {
      enable = true;
      matchParen.offscreen = {
        method = "popup";
        scrolloff = true;
      };
    };
  };
}
