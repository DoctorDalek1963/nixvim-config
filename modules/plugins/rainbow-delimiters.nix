{
  flake.nixvimModules.rainbow-delimiters = {
    plugins.rainbow-delimiters = {
      enable = true;

      settings = {
        strategy = {
          "" = "rainbow-delimiters.strategy.global";
          markdown = "rainbow-delimiters.strategy.no-op";
        };

        query = {
          "" = "rainbow-delimiters";
          lua = "rainbow-blocks";
        };
      };
    };
  };
}
