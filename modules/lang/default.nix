{
  lib,
  config,
  ...
}:
{
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
    diagnostic.settings.virtual_lines.current_line = true;

    opts = {
      # Backups can mess with LSPs
      backup = false;
      writebackup = false;
    };

    plugins = {
      # Allow non-LSP sources to hook into the native LSP system
      none-ls = {
        enable = true;
        sources.code_actions.proselint.enable = true;
      };

      # Native LSP completion with cmp
      cmp-nvim-lsp.enable = config.plugins.cmp.enable;
      cmp.settings.sources = lib.optional config.plugins.cmp.enable { name = "nvim_lsp"; };
    };

    autoGroups.lsp_format_augroup.clear = true;
    autoCmd = [
      {
        callback = lib.nixvim.mkRaw ''
          function(_t)
            if vim.lsp.get_clients()[1]:supports_method('textDocument/formatting') then
              vim.lsp.buf.format({ timeout=200 })
            end
          end
        '';
        event = [ "BufWritePre" ];
        pattern = [ "*" ];
      }
    ];

    lsp.keymaps = [
      {
        key = "gd";
        lspBufAction = "definition";
        options = {
          silent = true;
          desc = "Goto definition";
        };
      }
      {
        key = "<leader>f";
        lspBufAction = "format";
        options = {
          silent = true;
          desc = "Format buffer with LSP";
        };
      }
      {
        key = "K";
        lspBufAction = "hover";
        options = {
          silent = true;
          desc = "Hover symbol with LSP";
        };
      }
      {
        key = "gi";
        lspBufAction = "implementation";
        options = {
          silent = true;
          desc = "Goto implementation";
        };
      }
      {
        key = "gr";
        lspBufAction = "references";
        options = {
          silent = true;
          desc = "Goto references";
        };
      }
      {
        key = "<leader>rn";
        lspBufAction = "rename";
        options = {
          silent = true;
          desc = "Rename symbol with LSP";
        };
      }
      {
        key = "gy";
        lspBufAction = "type_definition";
        options = {
          silent = true;
          desc = "Goto type definition";
        };
      }

      {
        key = "<leader>j";
        action = lib.nixvim.mkRaw "function() vim.diagnostic.jump({ count=1, float=true }) end";
        options = {
          silent = true;
          desc = "Goto next LSP diagnostic";
        };
      }
      {
        key = "<leader>k";
        action = lib.nixvim.mkRaw "function() vim.diagnostic.jump({ count=-1, float=true }) end";
        options = {
          silent = true;
          desc = "Goto previous LSP diagnostic";
        };
      }
    ];
  };
}
