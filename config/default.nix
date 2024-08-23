{
  pkgs,
  lib,
  inputs,
  useNightly,
  rustLsp,
  ...
}: {
  imports = [
    ./autoCmdGroups.nix
    ./globals.nix
    ./keymaps.nix
    ./options.nix
    ./plugins/default.nix
  ];

  package = lib.mkIf useNightly inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;

  enableMan = false;

  extraPackages = with pkgs;
    [
      alejandra # For nixd lsp
      delta # For actions-preview.nvim
    ]
    ++ (
      if rustLsp
      then [
        pkgs.vscode-extensions.vadimcn.vscode-lldb # For Rustaceanvim debugging
      ]
      else []
    );

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

  userCommands = {
    Rmsp = {
      desc = "Remove all trailing spaces";
      command = "execute '%s/\\s\\+$//e'";
    };
  };

  extraConfigLua =
    # lua
    ''
      -- Add borders to floating windows
      do
        local _border = "rounded"

        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
          vim.lsp.handlers.hover, {
            border = _border
          }
        )

        vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
          vim.lsp.handlers.signature_help, {
            border = _border
          }
        )

        vim.diagnostic.config{
          float = {border = _border}
        }
      end
    '';
}
