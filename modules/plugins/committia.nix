{
  flake.nixvimModules.committia = {
    # Nicer commit editing with git
    plugins.committia = {
      enable = true;

      lazyLoad.settings.ft = "gitcommit";
    };
  };
}
