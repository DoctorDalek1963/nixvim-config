{
  lib,
  config,
  ...
}: {
  imports = [
    ./nix.nix

    ./c_cpp.nix
    ./configFiles.nix
    ./dlang
    ./dockerfile.nix
    ./elixir.nix
    ./haskell.nix
    ./julia.nix
    ./jvm.nix
    ./latex.nix
    ./lean4.nix
    ./lua.nix
    ./python.nix
    ./rust.nix
    ./shell.nix
    ./webDev.nix
    ./zig.nix
  ];

  config = lib.mkIf config.setup.lang.enable {
    # Highlight diagnostic locations only on the current line
    diagnostic.settings.virtual_lines.only_current_line = true;

    opts = {
      # Backups can mess with LSPs
      backup = false;
      writebackup = false;
    };

    plugins = {
      # Autoformatting for all servers that support it
      lsp-format = {
        enable = true;
        lspServersToEnable = "all";
      };

      # Highlight exact diagnostic locations on the line
      lsp-lines.enable = true;

      # See https://nix-community.github.io/nixvim/plugins/lsp/index.html for options and supported servers
      lsp = {
        enable = true;

        keymaps = {
          silent = true;
          lspBuf = {
            "gd" = "definition";
            "<leader>f" = "format";
            "K" = "hover";
            "gi" = "implementation";
            "gr" = "references";
            "<leader>rn" = "rename";
            "gy" = "type_definition";
          };
          diagnostic = {
            "<leader>j" = "goto_next";
            "<leader>k" = "goto_prev";
          };
        };
      };

      # Allow non-LSP sources to hook into the native LSP system
      none-ls = {
        enable = true;
        sources.code_actions.proselint.enable = true;
      };

      # Native LSP completion with cmp
      cmp-nvim-lsp.enable = config.plugins.cmp.enable;
      cmp.settings.sources = lib.optional config.plugins.cmp.enable {name = "nvim_lsp";};
    };
  };
}
