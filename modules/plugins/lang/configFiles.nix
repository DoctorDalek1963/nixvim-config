{
  lib,
  config,
  ...
}: let
  cfg = config.setup.lang;
in {
  config = lib.mkIf (cfg.enable && cfg.configFiles) {
    plugins.lsp.servers = {
      jsonls.enable = true;
      taplo.enable = true; # TOML
      yamlls.enable = true;
      lemminx.enable = true; # XML
    };
  };
}
