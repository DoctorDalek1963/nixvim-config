{
  lib,
  config,
  ...
}:
let
  cfg = config.setup.lang;
in
{
  config = lib.mkIf (cfg.enable && cfg.dockerfile) {
    lsp.servers.dockerls.enable = true;
  };
}
