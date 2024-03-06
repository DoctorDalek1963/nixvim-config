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
