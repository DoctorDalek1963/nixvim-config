{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.setup.lang;
in
{
  config = lib.mkIf (cfg.enable && cfg.rust) {
    # Use rust-analyzer from environment, typically via `nix develop`
    dependencies.rust-analyzer.enable = false;

    plugins = {
      # Extra tools for Cargo.toml files
      crates = {
        enable = true;
        settings = {
          # Enable code actions with none-ls
          null_ls = {
            enabled = true;
            name = "crates.nvim";
          };
        };
      };

      cmp.settings.sources = lib.optional config.plugins.cmp.enable { name = "crates.nvim"; };

      rustaceanvim = {
        enable = true;
        settings = {
          tools.hover_actions.replace_builtin_hover = false;
          server = {
            on_attach = "__lspOnAttach";
            default_settings.files.excludeDirs = [ ".direnv" ];
          };

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
