{
  lib,
  config,
  ...
}: let
  cfg = config.setup.lang;
in {
  config = lib.mkIf (cfg.enable && cfg.configFiles) {
    plugins.lsp.servers = {
      just.enable = true;
      jsonls.enable = true;
      taplo.enable = true; # TOML
      yamlls.enable = true;
      lemminx.enable = true; # XML
    };
  };
}
