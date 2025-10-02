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
        options.silent = true;
      }
      {
        key = "<leader>f";
        lspBufAction = "format";
        options.silent = true;
      }
      {
        key = "K";
        lspBufAction = "hover";
        options.silent = true;
      }
      {
        key = "gi";
        lspBufAction = "implementation";
        options.silent = true;
      }
      {
        key = "gr";
        lspBufAction = "references";
        options.silent = true;
      }
      {
        key = "<leader>rn";
        lspBufAction = "rename";
        options.silent = true;
      }
      {
        key = "gy";
        lspBufAction = "type_definition";
        options.silent = true;
      }

      {
        key = "<leader>j";
        action = lib.nixvim.mkRaw "function() vim.diagnostic.jump({ count=1, float=true }) end";
        options.silent = true;
      }
      {
        key = "<leader>k";
        action = lib.nixvim.mkRaw "function() vim.diagnostic.jump({ count=-1, float=true }) end";
        options.silent = true;
      }
    ];
  };
}
