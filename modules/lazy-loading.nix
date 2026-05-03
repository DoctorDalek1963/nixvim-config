{
  flake.nixvimModules.lazy-loading = {
    plugins.lz-n = {
      enable = true;
      autoLoad = true;
    };
  };
}
