{
  lib,
  config,
  ...
}: let
  cfg = config.setup.pluginGroups;
in {
  imports = [
    ./lang

    ./actions-preview.nix
    ./cmp.nix
    ./dap.nix
    ./git.nix
    ./lualine.nix
    ./markdown.nix
    ./mini.nix
    ./numb.nix
    ./pencil.nix
    ./telescope.nix
    ./transparent.nix
    ./treesitter.nix
    ./quick-scope.nix
    ./ufo.nix
    ./undotree.nix
    ./windows.nix
    ./yanky.nix
    ./yazi.nix
  ];

  config = lib.mkMerge [
    (lib.mkIf cfg.base {
      plugins = {
        # Nice icons for programming stuff
        web-devicons.enable = true;

        # Keep shell environment consistent with direnv
        direnv.enable = true;

        # Show indentation levels
        indent-blankline = {
          enable = true;
          settings.scope.enabled = false;
        };

        # Resume editing from the last place
        lastplace.enable = true;

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
        vim-surround.enable = true;

        # Make matching tags like () [] {} "" '' work better
        vim-matchup = {
          enable = true;
          settings.matchparen_offscreen = {
            method = "popup";
            scrolloff = 1;
          };
        };
      };
    })
    (lib.mkIf cfg.niceToHave {
      plugins = {
        # Make marks easier and nicer to use
        marks.enable = true;

        # Automatically pair brackets and quotes and things
        nvim-autopairs.enable = true;

        # Rainbow brackets and tags
        rainbow-delimiters.enable = true;

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
