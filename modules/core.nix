{ self, ... }:
{
  flake.nixvimModules.core = {
    imports = with self.nixvimModules; [
      autocmd-groups
      filetypes
      keymaps
      options
    ];

    enableMan = false;

    performance.byteCompileLua = {
      enable = true;
      configs = true;
      initLua = true;
      nvimRuntime = true;
      plugins = true;
    };

    userCommands = {
      Rmsp = {
        desc = "Remove all trailing spaces";
        command = "execute '%s/\\s\\+$//e'";
      };
    };

    globals = {
      mapleader = "\\";
      maplocalleader = "\\";
    };

    colorschemes.catppuccin = {
      enable = true;
      settings = {
        flavour = "macchiato";
        background = {
          light = "latte";
          dark = "macchiato";
        };
        dimInactive = {
          enabled = true;
          percentage = 0.15;
        };
        integrations = {
          cmp = true;
          gitgutter = true;
          rainbow_delimiters = true;
          treesitter = true;
          treesitter_context = true;
          dap = {
            enabled = true;
            enable_ui = true;
          };
          indent_blankline = {
            enabled = true;
            colored_indent_levels = true;
          };
          native_lsp = true;
          telescope = true;
        };
      };
    };
  };
}
