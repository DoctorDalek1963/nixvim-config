{pkgs, ...}: {
  extraPlugins = [
    pkgs.vimPlugins.actions-preview-nvim
  ];

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
    '';
}
