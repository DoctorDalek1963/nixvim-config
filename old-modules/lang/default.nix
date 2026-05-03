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
  };
}
