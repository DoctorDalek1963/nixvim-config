{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.setup.lsp;
in {
  config = lib.mkIf (cfg.enable && cfg.rust) {
    plugins = {
      # Extra tools for Cargo.toml files
      crates-nvim = {
        enable = true;
        extraOptions = {
          # Enable code actions with none-ls
          null_ls = {
            enabled = true;
            name = "crates.nvim";
          };
        };
      };

      rustaceanvim = {
        enable = true;
        rustAnalyzerPackage = null; # Use rust-analyzer from environment, typically via `nix develop`
        settings = {
          tools.hover_actions.replace_builtin_hover = false;
          server.on_attach = "__lspOnAttach";

          # This config was adapted from https://github.com/mrcjkb/rustaceanvim#using-codelldb-for-debugging
          dap.adapter =
            # lua
            ''
              function()
                local extension_path = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb"
                local codelldb_path = extension_path .. "/adapter/codelldb"
                local liblldb_path = extension_path .. "/lldb/lib/liblldb.so"

                return require("rustaceanvim.config").get_codelldb_adapter(codelldb_path, liblldb_path)
              end
            '';
        };
      };
    };
  };
}
