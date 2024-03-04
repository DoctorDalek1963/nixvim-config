{
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

    # Allow non-LSP sources to hook into the native LSP system
    none-ls = {
      enable = true;
      sources = {
        code_actions = {
          proselint.enable = true;
          statix.enable = true;
        };
        diagnostics = {
          deadnix.enable = true;
          statix.enable = true;
        };
      };
    };
  };
}
