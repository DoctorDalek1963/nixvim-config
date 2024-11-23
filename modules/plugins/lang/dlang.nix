{
  lib,
  config,
  ...
}: let
  cfg = config.setup.lang;
in {
  config = lib.mkIf (cfg.enable && cfg.dlang) {
    plugins.lsp.servers.serve_d.enable = true;
  };
}
