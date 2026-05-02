{ self, ... }:
{
  flake.nixvimModules = {
    plugin-group-base = {
      imports = with self.nixvimModules; [
        core

        lualine
        mini-ai # Text objects, not LLM
        mini-comment
        pencil
        quick-scope
        transparent
        treesitter
        ufo
        yanky
      ];
    };

    plugin-group-comfortable = {
      imports = with self.nixvimModules; [
        plugin-group-base

        auto-dark-mode
        oil
        mini-clue
        mini-diff
        numb
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
