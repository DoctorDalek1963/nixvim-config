{
  flake.nixvimModules.cmp = {
    plugins = {
      cmp = {
        enable = true;
        autoEnableSources = true;

        settings = {
          sources = [
            { name = "buffer"; } # Words in the current buffer
            { name = "path"; } # Filepaths
            { name = "spell"; } # English words
          ];

          completion.completeopt = "menu,menuone,popup,noselect";

          mapping = {
            "<C-space>" = "cmp.mapping.complete()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<down>" = "cmp.mapping.select_next_item()";
            "<up>" = "cmp.mapping.select_prev_item()";
            "<S-down>" = "cmp.mapping.scroll_docs(2)";
            "<S-up>" = "cmp.mapping.scroll_docs(-2)";
            "<Tab>" =
              # lua
              ''
                cmp.mapping(
                  function(fallback)
                    -- local luasnip = require("luasnip")

                    if cmp.visible() then
                      cmp.select_next_item()
                    -- elseif luasnip.jumpable(1) then
                      -- vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-next", true, true, true), "")
                      -- luasnip.jump(1)
                    else
                      fallback()
                    end
                  end,
                  { "i", "s" }
                )
              '';
            "<S-Tab>" =
              # lua
              ''
                cmp.mapping(
                  function(fallback)
                    -- local luasnip = require("luasnip")

                    if cmp.visible() then
                      cmp.select_prev_item()
                    -- elseif luasnip.jumpable(-1) then
                      -- vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
                      -- luasnip.jump(-1)
                    else
                      fallback()
                    end
                  end,
                  { "i", "s" }
                )
              '';
          };
        };
      };
    };
  };
}
