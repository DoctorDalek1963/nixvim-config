{
  lib,
  config,
  ...
}:
let
  cfg = config.setup.lang;
in
{
  config = lib.mkIf (cfg.enable && cfg.julia) {
    plugins.lsp.servers.julials.enable = true;
  };
}
