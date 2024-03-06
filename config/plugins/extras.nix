{pkgs, ...}: let
  providedPlugins = with pkgs.vimPlugins; [
    actions-preview-nvim
    numb-nvim
    nvim-web-devicons
    quick-scope
    tabular
    vim-pencil
    windows-nvim
  ];

  manualPlugins = [
    # Source for cmp
    (pkgs.vimUtils.buildVimPlugin
      {
        name = "cmp-dotenv";
        src = pkgs.fetchFromGitHub {
          owner = "SergioRibera";
          repo = "cmp-dotenv";
          rev = "fd78929551010bc20602e7e663e42a5e14d76c96";
          hash = "sha256-g1nw8E1uD2iyLJPRdgTp0MQgANjAdi9edyhhFRs2Ouo=";
        };
      })
    # Source for cmp
    (pkgs.vimUtils.buildVimPlugin
      {
        name = "cmp-vimtex";
        src = pkgs.fetchFromGitHub {
          owner = "micangl";
          repo = "cmp-vimtex";
          rev = "613fbfc54d9488252b0b0289d6d1d60242513558";
          hash = "sha256-07FqXsRe0RP5f3b6osrsi5gai+bZi9ybm5JL/nnBH+4=";
        };
      })
    # Source for cmp
    (pkgs.vimUtils.buildVimPlugin
      {
        name = "cmp_yanky";
        src = pkgs.fetchFromGitHub {
          owner = "chrisgrieser";
          repo = "cmp_yanky";
          rev = "c3d089186ccead26eba01023502f3eeadd7a92d2";
          hash = "sha256-jWNoKzY0x5GPFP7JsQi4nqgg1YFJV4DqxwJRqsg6KaQ=";
        };
      })

    # Needed by windows-nvim
    (pkgs.vimUtils.buildVimPlugin
      {
        name = "animation.nvim";
        src = pkgs.fetchFromGitHub {
          owner = "anuvyklack";
          repo = "animation.nvim";
          rev = "fb77091ab72ec9971aee0562e7081182527aaa6a";
          hash = "sha256-KyFzPI2B0ioIABnhC6MwaHYLcuUzSqCsmcGpMei4XXk=";
        };
      })
    # Needed by windows-nvim
    (pkgs.vimUtils.buildVimPlugin
      {
        name = "middleclass";
        src = pkgs.fetchFromGitHub {
          owner = "anuvyklack";
          repo = "middleclass";
          rev = "9fab4d5bca67262614960960ca35c4740eb2be2c";
          hash = "sha256-scJX7ovVZ6YBRp2lTP7JswyZ0smvVZneGRGBvwFsyOQ=";
        };
      })
  ];
in {
  extraPlugins = providedPlugins ++ manualPlugins;

  extraConfigLua =
    # lua
    ''
      require("actions-preview").setup {
        highlight_command = {
          require("actions-preview.highlight").delta("${pkgs.delta}/bin/delta --no-gitconfig --side-by-side")
        },
        telescope = vim.tbl_extend(
          "force",
          require("telescope.themes").get_dropdown(),
          {
            layout_config = {
              center = {
                height = 0.2,
                width = 0.8
              }
            }
          }
        ),
      }

      require('numb').setup()

      require("windows").setup({})
    '';
}
