{
  lib,
  config,
  ...
}: let
  cfg = config.setup.lang;
in {
  config = lib.mkIf (cfg.enable && cfg.jvm) {
    plugins.lsp.servers = {
      clojure_lsp.enable = true;
      java_language_server.enable = true;
      kotlin_language_server.enable = true;
      metals.enable = true; # Scala
    };
  };
}
