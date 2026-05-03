{
  flake.nixvimModules.haskell = {
    lsp.servers.hls = {
      enable = true;
      package = null; # Provided by environment
    };
  };
}
