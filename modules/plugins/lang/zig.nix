{
  lib,
  config,
  ...
}:
let
  cfg = config.setup.lang;
in
{
  config = lib.mkIf (cfg.enable && cfg.zig) {
    plugins.lsp.servers.zls.enable = true;
  };
}
