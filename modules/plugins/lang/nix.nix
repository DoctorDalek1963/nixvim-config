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
        # Why does Alejandra not work? I have no idea.
        # When I save one buffer, it formats it and overwrites any other open
        # nix buffers with the same formatted code. This is obviously very
        # annoying and I don't know why it's happening, so I'm disabling
        # Alejandra for a while.
        # settings.formatting.command = ["${pkgs.alejandra}/bin/alejandra" "--quiet"];
      };

      none-ls.sources = {
        code_actions = {
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
