{
  pkgs,
  lib,
  config,
  ...
}: let
  cfgTelescope = config.plugins.telescope.enable;
in {
  plugins.yanky = {
    enable = true;
    enableTelescope = cfgTelescope;
  };

  extraPlugins =
    lib.optional config.plugins.cmp.enable
    (pkgs.vimUtils.buildVimPlugin
      {
        name = "cmp_yanky";
        src = pkgs.fetchFromGitHub {
          owner = "chrisgrieser";
          repo = "cmp_yanky";
          rev = "c3d089186ccead26eba01023502f3eeadd7a92d2";
          hash = "sha256-jWNoKzY0x5GPFP7JsQi4nqgg1YFJV4DqxwJRqsg6KaQ=";
        };
      });

  plugins.cmp.settings.source = lib.optional config.plugins.cmp.enable {name = "cmp_yanky";};

  keymaps =
    [
      # Yanky put after
      {
        key = "p";
        action = "<Plug>(YankyPutAfter)";
        mode = ["n" "x"];
      }
      # Yanky put before
      {
        key = "P";
        action = "<Plug>(YankyPutBefore)";
        mode = ["n" "x"];
      }
      # Yanky g put after
      {
        key = "gp";
        action = "<Plug>(YankyGPutAfter)";
        mode = ["n" "x"];
      }
      # Yanky g put before
      {
        key = "gP";
        action = "<Plug>(YankyGPutBefore)";
        mode = ["n" "x"];
      }

      # Yanky previous ring entry
      {
        key = "<C-p>";
        action = "<Plug>(YankyPreviousEntry)";
        mode = "n";
      }
      # Yanky next ring entry
      {
        key = "<C-n>";
        action = "<Plug>(YankyNextEntry)";
        mode = "n";
      }
    ]
    ++ lib.optional cfgTelescope
    # Open yanky ring with Telescope
    {
      key = "<leader>ty";
      action = "<cmd>Telescope yank_history<cr>";
      mode = "n";
    };
}
