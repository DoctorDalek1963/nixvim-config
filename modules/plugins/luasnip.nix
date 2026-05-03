{
  flake.nixvimModules.luasnip =
    { lib, ... }:
    {
      plugins = {
        # Lots of good snippets for various languages
        friendly-snippets.enable = true;

        luasnip = {
          enable = true;
          # Load snippets from friendly-snippets
          fromVscode = [ { } ];
        };

        blink-cmp.settings = {
          sources = lib.mkBefore [ "snippets" ];
          snippets.preset = "luasnip";
        };
      };
    };
}
