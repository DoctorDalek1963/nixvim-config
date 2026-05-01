{
  lib,
  config,
  ...
}:
let
  cfg = config.setup.lang;
in
{
  config = lib.mkIf (cfg.enable && cfg.shell) {
    lsp.servers.bashls.enable = true;
  };
}
