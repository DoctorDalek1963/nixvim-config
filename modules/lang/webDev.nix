{
  lib,
  config,
  ...
}:
{
  config = lib.mkIf config.setup.lang.webDev {
    lsp.servers = {
      cssls.enable = true;
      html.enable = true;
      jsonls.enable = true;
      ts_ls.enable = true;
    };
  };
}
