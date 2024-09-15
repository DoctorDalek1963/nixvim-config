{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.setup.pluginGroups;
in
{
  imports = [
    ./lang

    ./actions-preview.nix
    ./cmp.nix
    ./dap.nix
    ./git.nix
    ./lualine.nix
    ./markdown.nix
    ./numb.nix
    ./telescope.nix
    ./treesitter.nix
    ./quick-scope.nix
    ./ufo.nix
    ./windows.nix
    ./yanky.nix
    ./yazi.nix
  ];

  config = lib.mkMerge [
    (lib.mkIf cfg.base {
      plugins = {
        # Show indentation levels
        indent-blankline = {
          enable = true;
          settings.scope.enabled = false;
        };

        # Resume editing from the last place
        lastplace.enable = true;

        # Make marks easier and nicer to use
        marks.enable = true;

        # Automatically pair brackets and quotes and things
        nvim-autopairs.enable = true;

        # Rainbow brackets and tags
        rainbow-delimiters.enable = true;

        # Improve w e b motions, basically camelCaseMotions
        spider = {
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

        # Handle delimiters like () [] {} "" '' better
        surround.enable = true;

        # Make matching tags like () [] {} "" '' work better
        vim-matchup = {
          enable = true;
          matchParen.offscreen = {
            method = "popup";
            scrolloff = true;
          };
        };
      };
    })
    (lib.mkIf cfg.niceToHave {
      extraPlugins = [ pkgs.vimPlugins.tabular ];

      plugins = {
        # Toggle comments with `gc`, `gb`, and friends
        comment.enable = true;

        # Debugging
        # Show update messages in the bottom right
        fidget = {
          enable = true;
          notification = {
            filter = "info";
            overrideVimNotify = true;
          };
        };
      };
    })
  ];
}
