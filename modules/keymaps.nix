{
  keymaps = [
    {
      key = "<leader>q";
      action = "<cmd>qa<cr>";
      mode = "n";
      options.desc = "Quit nvim";
    }
    {
      key = "<leader>Q";
      action = "<cmd>qa!<cr>";
      options.desc = "Force quit nvim";
    }
    {
      key = "<leader>w";
      action = "<cmd>wa<cr>";
      mode = "n";
      options.desc = "Write all open files";
    }
    {
      key = "<leader>W";
      action = "<cmd>wqa<cr>";
      mode = "n";
      options.desc = "Write all open files and quit";
    }
    {
      key = "<leader><leader>";
      action = "<cmd>w<cr>";
      mode = "n";
      options.desc = "Write current file";
    }
    {
      key = "<C-j>";
      action = "<C-w>j";
      mode = "n";
      options.desc = "Move to pane below";
    }
    {
      key = "<C-k>";
      action = "<C-w>k";
      mode = "n";
      options.desc = "Move to pane above";
    }
    {
      key = "<C-h>";
      action = "<C-w>h";
      mode = "n";
      options.desc = "Move to pane to the left";
    }
    {
      key = "<C-l>";
      action = "<C-w>l";
      mode = "n";
      options.desc = "Move to pane to the right";
    }
    {
      key = "<Bar>";
      action = "<C-w>v<C-w>l<C-w>n<C-w>j<C-w>c";
      mode = "n";
      options.desc = "Open empty buffer in vsplit";
    }
    {
      key = "-";
      action = "<C-w>n<C-w>x<C-w>j";
      mode = "n";
      options.desc = "Open empty buffer in split";
    }
    {
      key = "<leader><Bar>";
      action = "<C-w>v<C-w>l";
      mode = "n";
      options.desc = "Open current buffer in vsplit";
    }
    {
      key = "<leader>-";
      action = "<C-w>s<C-w>j";
      mode = "n";
      options.desc = "Open current buffer in split";
    }
    {
      key = "<leader>r";
      action = ''<cmd>!"%:p"<cr>'';
      mode = "n";
      options.desc = "Run the current file (requires shebang)";
    }
    {
      key = "<leader>R";
      action = ''<cmd>!clear<cr><cr><cmd>"%:p"<cr>'';
      mode = "n";
      options.desc = "Clear the terminal and run the current file (requires shebang)";
    }
    {
      key = "<leader>A";
      action = ''<cmd>!"%:p" '';
      mode = "n";
      options.desc = "Run the current file with arguments (requires shebang)";
    }
    {
      key = "<C-d>";
      action = "yyp";
      mode = "n";
      options.desc = "Duplicate current line";
    }
    {
      key = "<up>";
      action = "gk";
      mode = "n";
      options.desc = "Move one line up (ignores wrapping)";
    }
    {
      key = "<down>";
      action = "gj";
      mode = "n";
      options.desc = "Move one line down (ignores wrapping)";
    }
    {
      key = "<leader>;";
      action = "mqA;<esc>`qdmq";
      mode = "n";
      options.desc = "Add a semicolon to the end of the line";
    }
    {
      key = "<leader>,";
      action = "mqA,<esc>`qdmq";
      mode = "n";
      options.desc = "Add a comma to the end of the line";
    }
    {
      key = "<leader>:";
      action = "A:<esc>o";
      mode = "n";
      options.desc = "Add a colon to the end of the line and start a new line";
    }
    {
      key = "/";
      action = "/\\v";
      mode = "n";
      options.desc = "Always use very magic regex mode";
    }
    {
      key = "<leader>n";
      action = "<cmd>nohlsearch<cr>";
      mode = "n";
      options.desc = "Remove search highlight";
    }
    {
      key = "<leader>s";
      action = "<cmd>set spell!<cr>";
      mode = "n";
      options = {
        silent = true;
        desc = "Toggle spell check";
      };
    }
    {
      key = "<leader>z";
      action = "mq1z=`qdmq";
      mode = "n";
      options = {
        silent = true;
        desc = "Automatically fix spelling";
      };
    }
    {
      key = "<leader>cp";
      action = "<cmd>w !xclip -selection c<cr><cr>";
      mode = "n";
      options.desc = "Copy whole buffer to system clipboard";
    }
    {
      key = "<leader>cp";
      action = ''"+y'';
      mode = "v";
      options.desc = "Copy selected text to system clipboard";
    }
    {
      key = "<leader>a";
      action = "ggVG";
      mode = "n";
      options.desc = "Select everything in the buffer";
    }
    {
      key = "<leader>v";
      action.__raw =
        # lua
        ''
          function()
            local vt = vim.diagnostic.config().virtual_text
            vim.diagnostic.config({ virtual_text = not vt })
          end
        '';
      mode = "n";
      options = {
        silent = true;
        desc = "Toggle virtual text";
      };
    }
    {
      key = "<leader>i";
      action.__raw =
        # lua
        ''
          function()
            vim.lsp.inlay_hint.enable(vim.fn.bufnr(), not vim.lsp.inlay_hint.is_enabled())
          end
        '';
      mode = "n";
      options = {
        silent = true;
        desc = "Toggle inlay hints";
      };
    }
  ];
}
