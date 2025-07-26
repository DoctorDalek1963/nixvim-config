{
  lib,
  config,
  ...
}:
{
  config = lib.mkIf config.setup.pluginGroups.niceToHave {
    # Better folding
    plugins.nvim-ufo = {
      enable = true;
      settings.fold_virt_text_handler =
        # lua
        ''
          -- Taken directly from https://github.com/kevinhwang91/nvim-ufo/tree/a5390706f510d39951dd581f6d2a972741b3fa26#customize-fold-text
          function(virtText, lnum, endLnum, width, truncate)
            local newVirtText = {}
            local suffix = (' 󰁂 %d '):format(endLnum - lnum)
            local sufWidth = vim.fn.strdisplaywidth(suffix)
            local targetWidth = width - sufWidth
            local curWidth = 0
            for _, chunk in ipairs(virtText) do
              local chunkText = chunk[1]
              local chunkWidth = vim.fn.strdisplaywidth(chunkText)
              if targetWidth > curWidth + chunkWidth then
                table.insert(newVirtText, chunk)
              else
                chunkText = truncate(chunkText, targetWidth - curWidth)
                local hlGroup = chunk[2]
                table.insert(newVirtText, {chunkText, hlGroup})
                chunkWidth = vim.fn.strdisplaywidth(chunkText)
                -- str width returned from truncate() may less than 2nd argument, need padding
                if curWidth + chunkWidth < targetWidth then
                  suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
                end
                break
              end
              curWidth = curWidth + chunkWidth
            end
            table.insert(newVirtText, {suffix, 'MoreMsg'})
            return newVirtText
          end
        '';
    };

    plugins.lsp.capabilities =
      # lua
      ''
        capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true
        }
      '';

    keymaps = [
      {
        key = "zR";
        action.__raw = "require('ufo').openAllFolds";
        mode = "n";
        options.desc = "Open all folds";
      }
      {
        key = "zM";
        action.__raw = "require('ufo').closeAllFolds";
        mode = "n";
        options.desc = "Close all folds";
      }
      {
        key = "<space><space>";
        action = "za";
        mode = "n";
        options.desc = "Toggle current fold";
      }
      {
        key = "<leader><space>";
        action = "zA";
        mode = "n";
        options.desc = "Toggle current fold recursively";
      }
    ];
  };
}
