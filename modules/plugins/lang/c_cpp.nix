{
  lib,
  config,
  ...
}:
let
  cfg = config.setup.lang;
in
{
  config = lib.mkIf (cfg.enable && cfg.c_cpp) {
    plugins.lsp.servers.ccls.enable = true;
  };
}
