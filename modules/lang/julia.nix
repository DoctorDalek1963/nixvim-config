{
  flake.nixvimModules.julia = {
    lsp.servers.julials = {
      enable = true;
      package = null; # Provided by environment
    };
  };
}
