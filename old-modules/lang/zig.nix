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
    lsp.servers.zls = {
      enable = true;
      package = null; # Provided by environment
    };
  };
}
