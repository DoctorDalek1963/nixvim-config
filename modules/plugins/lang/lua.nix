{
  lib,
  config,
  ...
}:
let
  cfg = config.setup.lang;
in
{
  config = lib.mkIf (cfg.enable && cfg.lua) {
    plugins.lsp.servers.lua_ls.enable = true;
  };
}
