{
  flake.nixvimModules.zig = {
    lsp.servers.zls = {
      enable = true;
      package = null; # Provided by environment
    };
  };
}
