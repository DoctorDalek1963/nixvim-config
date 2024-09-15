{
  lib,
  config,
  ...
}:
let
  cfg = config.setup.lang;
in
{
  config = lib.mkIf (cfg.enable && cfg.haskell) {
    plugins.lsp.servers.hls.enable = true;
  };
}
