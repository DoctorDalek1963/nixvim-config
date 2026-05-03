{
  flake.nixvimModules.indent-blankline = {
    # Show indentation levels
    plugins.indent-blankline = {
      enable = true;
      settings.scope.enabled = false;
    };
  };
}
