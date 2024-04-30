{
  dapDebugger,
  leanNvim,
  ...
}: {
  imports = [
    ./cmp.nix
    ./extras.nix
    ./lsp.nix
    ./lualine.nix
    ./none-ls.nix
    ./treesitter.nix
    ./ufo.nix
  ];

  plugins = {
    # Toggle comments with `gc`, `gb`, and friends
    comment.enable = true;

    # Nicer commit editing with git
    committia.enable = true;

    # Debugging
    dap = {
      enable = dapDebugger;
      extensions = {
        dap-ui.enable = dapDebugger;
        dap-virtual-text.enable = dapDebugger;
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
      settings.scope.enabled = false;
    };

    # Resume editing from the last place
    lastplace.enable = true;

    # Integration with the Lean 4 theorem prover
    lean = {
      enable = leanNvim;
      # Unicode expansion is handled by nvim-cmp with latex-symbols, but
      # lean.nvim's abbreviations work indepently, and automatically insert
      # themselves when you press space to move on, rather than needing to be
      # manually selected from the pop-up menu
      abbreviations.enable = true;
    };

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
      extensions.file-browser = {
        enable = true;
        settings.hijack-netrw = true; # Use this when opening a directory with nvim
      };
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
