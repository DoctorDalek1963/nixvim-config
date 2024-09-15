{
  lib,
  config,
  ...
}: let
  cfg = config.setup.lang;
in {
  config = lib.mkIf (cfg.enable && cfg.nix) {
    plugins = {
      lsp.servers.nixd = {
        enable = true;
        # It seems like something in my config is stopping alejandra playing
        # nice with nixd. When I save one buffer, it formats it and overwrites
        # any other open nix buffers with the same formatted code. This is
        # obviously very annoying and I don't know why it's happening, so I'm using none-ls to do all my alejandra formatting.
        settings.formatting.command = null;
      };

      none-ls.sources = {
        code_actions = {
          statix.enable = true;
        };
        diagnostics = {
          deadnix.enable = true;
          statix.enable = true;
        };
        formatting = {
          alejandra.enable = true;
        };
      };
    };
  };
}
