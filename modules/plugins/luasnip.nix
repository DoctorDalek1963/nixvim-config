{
  flake.nixvimModules.luasnip =
    { config, ... }:
    {
      plugins = {
        # Lots of good snippets for various languages
        friendly-snippets.enable = true;

        luasnip = {
          enable = true;
          # Load snippets from friendly-snippets
          fromVscode = [ { } ];
        };

        cmp_luasnip.enable = config.plugins.cmp.enable;

        cmp.settings = {
          sources = [ { name = "luasnip"; } ];

          snippet.expand =
            # lua
            ''
              function(args)
                require('luasnip').lsp_expand(args.body)
              end
            '';
        };
      };
    };
}
