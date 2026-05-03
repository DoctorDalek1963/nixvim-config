{ self, ... }:
{
  flake.nixvimModules = {
    plugin-group-base = {
      imports = with self.nixvimModules; [
        core

        indent-blankline
        lualine
        mini-ai # Text objects, not LLM
        mini-comment
        nvim-autopairs
        pencil
        quick-scope
        spider
        transparent
        treesitter
        ufo
        vim-matchup
        vim-surround
        web-devicons
        yanky
      ];
    };

    plugin-group-comfortable = {
      imports = with self.nixvimModules; [
        plugin-group-base

        auto-dark-mode
        fidget
        lastplace
        mini-clue
        mini-diff
        numb
        oil
        rainbow-delimiters
        windows
      ];
    };

    plugin-group-programming = {
      imports = with self.nixvimModules; [
        plugin-group-comfortable

        actions-preview
        cmp
        committia
        dap
        # luasnip # I don't currently use snippets
        markdown-preview
        undotree
      ];
    };
  };
}
