{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.setup.lang;
  latexEnable = cfg.enable && cfg.latex;
in
{
  config = lib.mkMerge [
    (lib.mkIf latexEnable {
      # TODO: Make sure the LaTeX reference manual is installed as an info node:
      # https://github.com/astoff/digestif/wiki/Common-installation-issues#info-nodes
      lsp.servers.digestif.enable = true;

      plugins = {
        vimtex = {
          enable = true;

          # Use packages installed in the environment
          texlivePackage = null;
          zathuraPackage = null;

          settings.view_method = "zathura";
        };

        efmls-configs = {
          enable = true;
          externallyManagedPackages = [ "chktex" ];
          setup.tex.linter = "chktex";
        };
      };

      globals = {
        vimtex_log_ignore = [ "Viewer cannot find Zathura window ID" ];
        vimtex_syntax_conceal_disable = 1;
      };

      keymaps = [
        {
          action = "<cmd>VimtexView<cr>";
          key = "<C-space>";
          options = {
            silent = true;
            desc = "Highlight this part of the document in the PDF viewer";
          };
        }
      ];
    })
    (lib.mkIf (latexEnable && config.plugins.cmp.enable) {
      plugins = {
        cmp-latex-symbols.enable = true;
        cmp.settings.sources = [
          { name = "latex_symbols"; }
          { name = "vimtex"; }
        ];
      };

      extraPlugins = [ pkgs.vimPlugins.cmp-vimtex ];
    })
  ];
}
