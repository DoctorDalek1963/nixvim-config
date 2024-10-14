{
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.setup.lang.webDev {
    plugins.lsp.servers = {
      cssls.enable = true;
      html.enable = true;
      jsonls.enable = true;
      ts_ls.enable = true;
    };
  };
}
