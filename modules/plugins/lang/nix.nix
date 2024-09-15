{
  pkgs,
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
        settings.formatting.command = [ "${pkgs.nixfmt-rfc-style}/bin/nixfmt" ];
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
