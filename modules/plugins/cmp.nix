{pkgs, ...}: {
  plugins = {
    # Lots of good snippets for various languages
    friendly-snippets.enable = true;

    luasnip = {
      enable = true;
      # Load snippets from friendly-snippets
      fromVscode = [{}];
    };

    cmp-buffer.enable = true; # Words in the current buffer
    # cmp-dap.enable = true; # Debugging stuff
    cmp_luasnip.enable = true;
    # cmp-nvim-lsp.enable = true; # Native LSP
    cmp-nvim-lua.enable = true; # Nvim Lua API
    cmp-path.enable = true; # Filepaths
    cmp-spell.enable = true; # English words

    cmp = {
      enable = true;
      autoEnableSources = false;

      settings = {
        sources = [
          {name = "buffer";}
          # {name = "crates";} # From crates.nvim in none-ls.nix
          # {name = "dap";}
          {name = "dotenv";}
          {name = "luasnip";}
          # {name = "nvim_lsp";}
          {name = "nvim_lua";}
          {name = "path";}
          {name = "spell";}
        ];

        snippet.expand =
          # lua
          ''
            function(args)
              require('luasnip').lsp_expand(args.body)
            end
          '';

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
                  local luasnip = require("luasnip")

                  if cmp.visible() then
                    cmp.select_next_item()
                  elseif luasnip.jumpable(1) then
                    -- vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-next", true, true, true), "")
                    luasnip.jump(1)
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
                  local luasnip = require("luasnip")

                  if cmp.visible() then
                    cmp.select_prev_item()
                  elseif luasnip.jumpable(-1) then
                    -- vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
                    luasnip.jump(-1)
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

  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin
      {
        name = "cmp-dotenv";
        src = pkgs.fetchFromGitHub {
          owner = "SergioRibera";
          repo = "cmp-dotenv";
          rev = "4dd53aab60982f1f75848aec5e6214986263325e";
          hash = "sha256-EY0yu6wugw2cweTOYkdAXW4FZFh6SdTPsVncqrnrc14=";
        };
      })
  ];
}
