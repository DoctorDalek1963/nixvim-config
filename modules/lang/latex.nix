{
  flake.nixvimModules.latex = {
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
        languages.tex.linter = "chktex";
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
  };
}
