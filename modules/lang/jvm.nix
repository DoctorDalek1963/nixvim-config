{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.setup.lang;
in
{
  config = lib.mkIf (cfg.enable && cfg.jvm) {
    lsp.servers = {
      # clojure_lsp.enable = true;
      kotlin_language_server.enable = true;
      # metals.enable = true; # Scala
    };

    plugins.jdtls = {
      enable = true;
      settings.cmd = [
        "${pkgs.jdt-language-server}/bin/jdtls"
        "-configuration"
        { __raw = ''vim.env.HOME .. "/.cache/jdtls"''; }
        "-data"
        { __raw = ''require("jdtls.setup").find_root({".git", "mvnw", "gradlew"}) .. "/.jdtls"''; }
      ];
    };
  };
}
