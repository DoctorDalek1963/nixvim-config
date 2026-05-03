{
  lib,
  config,
  ...
}:
let
  cfg = config.setup.pluginGroups;
in
{
  config = lib.mkMerge [
    (lib.mkIf cfg.niceToHave {
      plugins = {
        # Make marks easier and nicer to use
        marks.enable = true;

        # Automatically pair brackets and quotes and things
        nvim-autopairs.enable = true;

        # Rainbow brackets and tags
        rainbow-delimiters = {
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

        # Debugging
        # Show update messages in the bottom right
        fidget = {
          enable = true;
          settings.notification = {
            filter = "info";
            override_vim_notify = true;

            # Transparency
            window.winblend = 0;
          };
        };
      };
    })
  ];
}
