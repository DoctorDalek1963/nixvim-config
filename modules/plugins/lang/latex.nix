{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.setup.lang;
  latexEnable = cfg.enable && cfg.latex;
in {
  config = lib.mkMerge [
    (lib.mkIf latexEnable {
      plugins = {
        vimtex = {
          enable = true;
          # Use the texlive installed in the environment
          texlivePackage = null;
        };

        # TODO: Make sure the LaTeX reference manual is installed as an info node:
        # https://github.com/astoff/digestif/wiki/Common-installation-issues#info-nodes
        lsp.servers.digestif.enable = true;
      };

      globals = {
        vimtex_view_general_viewer = "evince";
        vimtex_syntax_conceal_disable = 1;
      };
    })
    (lib.mkIf (latexEnable && config.plugins.cmp.enable) {
      plugins = {
        cmp-latex-symbols.enable = true;
        cmp.settings.sources = [
          {name = "latex_symbols";}
          {name = "vimtex";}
        ];
      };

      extraPlugins = [
        (pkgs.vimUtils.buildVimPlugin
          {
            name = "cmp-vimtex";
            src = pkgs.fetchFromGitHub {
              owner = "micangl";
              repo = "cmp-vimtex";
              rev = "5283bf9108ef33d41e704027b9ef22437ce7a15b";
              hash = "sha256-pD2dPdpyn5A/uwonDdAxCX138yBeDqbXDdlG/IKjVTU=";
            };
          })
      ];
    })
  ];
}
