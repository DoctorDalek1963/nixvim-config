{
  flake.nixvimModules.blink =
    { lib, ... }:
    {
      plugins.blink-cmp = {
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
                score_offset = 100;
                opts = {
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
}
