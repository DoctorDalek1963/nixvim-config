{
  # Better folding
  plugins.nvim-ufo = {
    enable = true;
    foldVirtTextHandler =
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
      action = "require('ufo').openAllFolds";
      lua = true;
      mode = "n";
    }
    {
      key = "zM";
      action = "require('ufo').closeAllFolds";
      lua = true;
      mode = "n";
    }

    # Toggle folds with space
    {
      key = "<space><space>";
      action = "za";
      mode = "n";
    }
    {
      key = "<leader><space>";
      action = "zA";
      mode = "n";
    }
  ];
}
