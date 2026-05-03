{
  flake.nixvimModules.spider = {
    # Improve w e b motions, basically camelCaseMotions
    plugins.spider = {
      enable = true;
      keymaps = {
        motions = {
          b = "b";
          e = "e";
          ge = "ge";
          w = "w";
        };
        silent = true;
      };
    };
  };
}
