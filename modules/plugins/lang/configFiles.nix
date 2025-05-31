{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.setup.lang;
in {
  config = lib.mkIf (cfg.enable && cfg.configFiles) {
    plugins.lsp.servers = {
      just = {
        enable = true;
        # TODO (just-lsp 0.2.3): Remove this patch once
        # https://github.com/terror/just-lsp/pull/77
        # is merged and upstreamed to nixpkgs
        package = pkgs.just-lsp.overrideAttrs (oldAttrs: {
          patches = (oldAttrs.patches or []) ++ [./just-lsp.patch];
        });
      };

      jsonls.enable = true;
      taplo.enable = true; # TOML
      yamlls.enable = true;
      lemminx.enable = true; # XML
    };
  };
}
