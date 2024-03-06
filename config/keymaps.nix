let
  baseKeymaps = [
    # Quit vim
    {
      key = "<leader>q";
      action = "<cmd>qa<cr>";
      mode = "n";
    }
    # Force quit
    {
      key = "<leader>Q";
      action = "<cmd>qa!<cr>";
    }

    # Write all open files
    {
      key = "<leader>w";
      action = "<cmd>wa<cr>";
      mode = "n";
    }
    # Write all open files and quit
    {
      key = "<leader>W";
      action = "<cmd>wqa<cr>";
      mode = "n";
    }

    # Write current file
    {
      key = "<leader><leader>";
      action = "<cmd>w<cr>";
      mode = "n";
    }

    # Easier directional navigation between panes
    {
      key = "<C-j>";
      action = "<C-w>j";
      mode = "n";
    }
    {
      key = "<C-k>";
      action = "<C-w>k";
      mode = "n";
    }
    {
      key = "<C-h>";
      action = "<C-w>h";
      mode = "n";
    }
    {
      key = "<C-l>";
      action = "<C-w>l";
      mode = "n";
    }

    # Easier splitting into new panes
    # Open empty buffer by default
    {
      key = "<Bar>";
      action = "<C-w>v<C-w>l<C-w>n<C-w>j<C-w>c";
      mode = "n";
    }
    {
      key = "-";
      action = "<C-w>n<C-w>x<C-w>j";
      mode = "n";
    }

    # Open current file with leader
    {
      key = "<leader><Bar>";
      action = "<C-w>v<C-w>l";
      mode = "n";
    }
    {
      key = "<leader>-";
      action = "<C-w>s<C-w>j";
      mode = "n";
    }

    # Run current file
    {
      key = "<leader>r";
      action = ''<cmd>!"%:p"<cr>'';
      mode = "n";
    }

    # Clear the terminal and run the current file
    {
      key = "<leader>R";
      action = ''<cmd>!clear<cr><cr><cmd>"%:p"<cr>'';
      mode = "n";
    }

    # Run current file with arguments
    {
      key = "<leader>A";
      action = ''<cmd>!"%:p" '';
      mode = "n";
    }

    # Duplicate the current line
    {
      key = "<C-d>";
      action = "yyp";
      mode = "n";
    }

    # Don't skip wrapped lines with arrow keys
    {
      key = "<up>";
      action = "g<up>";
      mode = "n";
    }
    {
      key = "<down>";
      action = "g<down>";
      mode = "n";
    }

    # Toggle folds with space
    {
      key = "<space><space>";
      action = "za";
      mode = "n";
    }
    {
      key = "<leader><space>";
      action = "zA";
      mode = "n";
    }

    # Clear the terminal
    {
      key = "<leader>cl";
      action = "<cmd>!clear<cr><cr>";
      mode = "n";
    }

    # Remove search highlight
    {
      key = "<leader>cl";
      action = "<cmd>!clear<cr><cr>";
      mode = "n";
      options.silent = true;
    }

    # Add a semicolon or comma to the end of a line
    {
      key = "<leader>;";
      action = "mqA;<esc>`q";
      mode = "n";
    }
    {
      key = "<leader>,";
      action = "mqA,<esc>`q";
      mode = "n";
    }

    # Add a colon to the end of the line and start a new line
    {
      key = "<leader>:";
      action = "A:<esc>o";
      mode = "n";
    }

    # Always use very magic regex mode
    {
      key = "/";
      action = "/\\v";
      mode = "n";
    }

    # Turn off highlighting after a search
    {
      key = "<leader>n";
      action = "<cmd>nohlsearch<cr>";
      mode = "n";
    }

    # Toggle spell check
    {
      key = "<leader>s";
      action = "<cmd>set spell!<cr>";
      mode = "n";
      options.silent = true;
    }

    # Automatically fix spelling
    {
      key = "<leader>z";
      action = "mq1z=`q";
      mode = "n";
      options.silent = true;
    }

    # Copy whole buffer to system clipboard
    {
      key = "<leader>cp";
      action = "<cmd>w !xclip -selection c<cr><cr>";
      mode = "n";
    }

    # Copy selected text to system clipboard
    {
      key = "<leader>cp";
      action = ''"+y'';
      mode = "v";
    }

    # Select everything in the buffer
    {
      key = "<leader>a";
      action = "ggVG";
      mode = "n";
    }

    # Toggle virtual text
    {
      key = "<leader>v";
      action =
        # lua
        ''
          function()
            local vt = vim.diagnostic.config().virtual_text
            vim.diagnostic.config({ virtual_text = not vt })
          end
        '';
      lua = true;
      mode = "n";
      options.silent = true;
    }

    # Toggle inlay hints
    {
      key = "<leader>i";
      action =
        # lua
        ''
          function()
            vim.lsp.inlay_hint.enable(vim.fn.bufnr(), not vim.lsp.inlay_hint.is_enabled())
          end
        '';
      lua = true;
      mode = "n";
      options.silent = true;
    }
  ];
  pluginKeymaps = [
    # Toggle goyo and vim-pencil
    {
      key = "<leader>g";
      action = "<cmd>Goyo<cr><cmd>SoftPencil<cr>";
      mode = "n";
      options.silent = true;
    }

    # Open code actions with preview
    {
      key = "<M-return>";
      action = "require('actions-preview').code_actions";
      lua = true;
      mode = "n";
      options.silent = true;
    }

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
    # Open yanky ring with Telescope
    {
      key = "<leader>ty";
      action = "<cmd>Telescope yank_history<cr>";
      mode = "n";
    }

    # Toggle DAP breakpoint
    {
      key = "<leader>db";
      action = "require('dap').toggle_breakpoint";
      lua = true;
      mode = "n";
      options.silent = true;
    }
    # DAP continue
    {
      key = "<leader>dc";
      action = "require('dap').continue";
      lua = true;
      mode = "n";
      options.silent = true;
    }
    # DAP step over
    {
      key = "<leader>dso";
      action = "require('dap').step_over";
      lua = true;
      mode = "n";
      options.silent = true;
    }
    # DAP step into
    {
      key = "<leader>dsi";
      action = "require('dap').step_into";
      lua = true;
      mode = "n";
      options.silent = true;
    }
    # Open DAP REPL
    {
      key = "<leader>dr";
      action = "require('dap').repl.open";
      lua = true;
      mode = "n";
      options.silent = true;
    }
    # Open DAP UI
    {
      key = "<leader>dui";
      action =
        # lua
        ''
          function()
            require('dapui').setup()
            require('dapui').toggle()
          end
        '';
      lua = true;
      mode = "n";
      options.silent = true;
    }

    # Open undo tree
    {
      key = "<leader>u";
      action = "<cmd>UndotreeToggle<cr>";
      mode = "n";
    }

    # Maximize the current window
    {
      key = "<C-w><C-w>";
      action = "<cmd>WindowsMaximize<cr>";
      mode = "n";
      options.silent = true;
    }

    # Yanky put after
    {
      key = "p";
      action = "<Plug>(YankyPutAfter)";
      mode = ["n" "x"];
    }
    # Yanky put before
    {
      key = "P";
      action = "<Plug>(YankyPutBefore)";
      mode = ["n" "x"];
    }
    # Yanky g put after
    {
      key = "gp";
      action = "<Plug>(YankyGPutAfter)";
      mode = ["n" "x"];
    }
    # Yanky g put before
    {
      key = "gP";
      action = "<Plug>(YankyGPutBefore)";
      mode = ["n" "x"];
    }

    # Yanky previous ring entry
    {
      key = "<C-p>";
      action = "<Plug>(YankyPreviousEntry)";
      mode = "n";
    }
    # Yanky next ring entry
    {
      key = "<C-n>";
      action = "<Plug>(YankyNextEntry)";
      mode = "n";
    }
  ];
in {
  keymaps = baseKeymaps ++ pluginKeymaps;
}
