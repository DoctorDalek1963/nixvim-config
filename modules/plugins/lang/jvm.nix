{
  lib,
  config,
  ...
}:
let
  cfg = config.setup.lang;
in
{
  config = lib.mkIf (cfg.enable && cfg.jvm) {
    plugins.lsp.servers = {
      clojure-lsp.enable = true;
      java-language-server.enable = true;
      kotlin-language-server.enable = true;
      metals.enable = true; # Scala
    };
  };
}
