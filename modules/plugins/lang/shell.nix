{
  lib,
  config,
  ...
}: let
  cfg = config.setup.lang;
in {
  config = lib.mkIf (cfg.enable && cfg.shell) {
    plugins.lsp.servers.bashls.enable = true;
  };
}
