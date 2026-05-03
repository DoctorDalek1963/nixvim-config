{
  flake.nixvimModules.lean4 = {
    # Use Lean from the environment
    dependencies.lean.enable = false;

    plugins.lean = {
      enable = true;
      settings.abbreviations.enable = true;

      lazyLoad.settings.ft = "lean";
    };
  };
}
