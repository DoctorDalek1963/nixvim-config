{
  flake.nixvimModules.lsp =
    { lib, ... }:
    {
      # Highlight diagnostic locations only on the current line
      diagnostic.settings.virtual_lines.current_line = true;

      opts = {
        # Backups can mess with LSPs
        backup = false;
        writebackup = false;
      };

      plugins = {
        blink-cmp = {
          setupLspCapabilities = true;

          settings = {
            sources.default = lib.mkBefore [ "lsp" ];

            signature = {
              enabled = true;
              window.show_documentation = false;
            };

            completion.menu.draw = {
              # We don't need label_description now because label and label_description
              # are already combined together in label by colorful-menu.nvim
              columns = [
                [ "kind_icon" ]
                {
                  __unkeyed = "label";
                  gap = 1;
                }
              ];

              components.label = {
                text.__raw = ''
                  function(ctx)
                    return require("colorful-menu").blink_components_text(ctx)
                  end
                '';

                highlight.__raw = ''
                  function(ctx)
                    return require("colorful-menu").blink_components_highlight(ctx)
                  end
                '';
              };
            };
          };
        };

        colorful-menu.enable = true;

        # Allow non-LSP sources to hook into the native LSP system
        none-ls.enable = true;
      };

      autoGroups.lsp_format_augroup.clear = true;
      autoCmd = [
        {
          callback.__raw = ''
            function(_t)
              for i, client in ipairs(vim.lsp.get_clients()) do
                if client.supports_method('textDocument/formatting') then
                  vim.lsp.buf.format({ timeout=200 })
                  return
                end
              end
            end
          '';
          event = [ "BufWritePre" ];
          pattern = [ "*" ];
          group = "lsp_format_augroup";
        }
      ];

      lsp.keymaps = [
        {
          key = "gd";
          lspBufAction = "definition";
          options = {
            silent = true;
            desc = "Goto definition";
          };
        }
        {
          key = "<leader>f";
          lspBufAction = "format";
          options = {
            silent = true;
            desc = "Format buffer with LSP";
          };
        }
        {
          key = "K";
          lspBufAction = "hover";
          options = {
            silent = true;
            desc = "Hover symbol with LSP";
          };
        }
        {
          key = "gi";
          lspBufAction = "implementation";
          options = {
            silent = true;
            desc = "Goto implementation";
          };
        }
        {
          key = "gr";
          lspBufAction = "references";
          options = {
            silent = true;
            desc = "Goto references";
          };
        }
        {
          key = "<leader>rn";
          lspBufAction = "rename";
          options = {
            silent = true;
            desc = "Rename symbol with LSP";
          };
        }
        {
          key = "gy";
          lspBufAction = "type_definition";
          options = {
            silent = true;
            desc = "Goto type definition";
          };
        }

        {
          key = "<leader>j";
          action.__raw = "function() vim.diagnostic.jump({ count=1, float=true }) end";
          options = {
            silent = true;
            desc = "Goto next LSP diagnostic";
          };
        }
        {
          key = "<leader>k";
          action.__raw = "function() vim.diagnostic.jump({ count=-1, float=true }) end";
          options = {
            silent = true;
            desc = "Goto previous LSP diagnostic";
          };
        }
      ];
    };
}
