{
  imports = [
    ./cmp.nix
    ./extras.nix
    ./lightline.nix
    ./lsp.nix
    ./none-ls.nix
  ];

  plugins = {
    # Toggle comments with `gc`, `gb`, and friends
    comment-nvim.enable = true;

    # Nicer commit editing with git
    committia.enable = true;

    # Debugging
    dap = {
      enable = true;
      extensions = {
        dap-ui.enable = true;
        dap-virtual-text.enable = true;
      };
    };

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

    # For markdown files
    goyo.enable = true;

    # Highlight inline strings with other languages in Nix files
    hmts.enable = true;

    # Show indentation levels
    indent-blankline = {
      enable = true;
      scope.enabled = false;
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

    # Telescope
    telescope = {
      enable = true;
      extensions.file_browser = {
        enable = true;
        hijackNetrw = true; # Use this when opening a directory with nvim
      };
    };

    # Treesitter grammar
    treesitter = {
      enable = true;
      ensureInstalled = "all";
      folding = true;
      indent = true;
    };

    # Add scope context with treesitter
    treesitter-context.enable = true;

    # Automatically close and rename HTML-like tags in pairs with Treesitter
    ts-autotag.enable = true;

    # Use the correct comment syntax for embedded languages
    ts-context-commentstring.enable = true;

    # See a tree of undo history
    undotree.enable = true;

    # Make matching tags like () [] {} "" '' work better
    vim-matchup = {
      enable = true;
      treesitterIntegration.enable = true;
      matchParen.offscreen = {
        method = "popup";
        scrolloff = true;
      };
    };

    # Integrate LaTeX
    vimtex = {
      enable = true;
      # Use the texlive installed system-wide
      texlivePackage = null;
    };

    # Make yanking better. See keymaps
    yanky = {
      enable = true;
      picker.telescope.enable = true;
    };
  };
}
