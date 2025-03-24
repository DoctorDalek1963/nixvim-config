{
  lib,
  config,
  ...
}: let
  cfg = config.setup.lang;
in {
  config = lib.mkIf (cfg.enable && cfg.jvm) {
    plugins = {
      lsp.servers = {
        # clojure_lsp.enable = true;
        kotlin_language_server.enable = true;
        # metals.enable = true; # Scala
      };

      nvim-jdtls = {
        enable = true;
        data = "/home/dyson/.cache/jdtls/workspaceData";
      };
    };
  };
}
