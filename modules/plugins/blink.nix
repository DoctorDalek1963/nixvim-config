{
  flake.nixvimModules.blink =
    { lib, ... }:
    {
      plugins = {
        blink-cmp-spell = {
          enable = true;
          autoLoad = true;
        };

        blink-cmp = {
          enable = true;

          setupLspCapabilities = lib.mkDefault false;

          settings = {
            sources = {
              default = [
                "spell"
                "buffer"
                "path"
              ];

              providers = {
                spell = {
                  module = "blink-cmp-spell";
                  name = "Spell";
                  opts = {
                    enable_in_context.__raw = ''
                      function()
                        local curpos = vim.api.nvim_win_get_cursor(0)
                        local captures = vim.treesitter.get_captures_at_pos(
                          0,
                          curpos[1] - 1,
                          curpos[2] - 1
                        )

                        for _, cap in ipairs(captures) do
                          if cap.capture == 'spell' then
                            return true
                          elseif cap.capture == 'nospell' then
                            return false
                          end
                        end

                        return false
                      end
                    '';
                  };
                };
              };
            };

            # Sort spelling suggestions alphabetically
            fuzzy.sorts = [
              (lib.nixvim.mkRaw ''
                function(a, b)
                  if a.source_id == 'spell' and b.source_id == 'spell' then
                    return require('blink.cmp.fuzzy.sort').label(a, b)
                  end
                end
              '')
              "score"
              "kind"
              "label"
            ];

            keymap.preset = "enter";
            completion.list.selection = {
              preselect = false;
              auto_insert = false;
            };
          };
        };
      };
    };
}
