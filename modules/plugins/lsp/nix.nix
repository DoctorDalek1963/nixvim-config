{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.setup.lsp;
in {
  config = lib.mkIf (cfg.enable && cfg.nix) {
    plugins.lsp.servers.nixd = {
      enable = true;
      settings.formatting.command = ["${pkgs.alejandra}/bin/alejandra" "--quiet"];
    };
  };
}
