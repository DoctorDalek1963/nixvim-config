{
  flake.nixvimModules.python = {
    lsp.servers.basedpyright.enable = true;
    plugins.none-ls = {
      sources.formatting.black.enable = true;
      lazyLoad.settings.ft = [ "python" ];
    };
  };
}
