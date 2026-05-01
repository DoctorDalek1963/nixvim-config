{
  lib,
  config,
  ...
}:
{
  config = lib.mkMerge [
    (lib.mkIf config.setup.pluginGroups.base {
      plugins.mini = {
        enable = true;
        modules = {
          # Improve text objects, not LLM
          ai = {
            n_lines = 200;
          };
        };
      };
    })
    (lib.mkIf config.setup.pluginGroups.niceToHave {
      plugins.mini.modules = {
        # Like which-key
        clue = {
          triggers = {
            "__unkeyed-1" = {
              mode = "n";
              keys = "<leader>";
            };
            "__unkeyed-2" = {
              mode = "x";
              keys = "<leader>";
            };

            "__unkeyed-3" = {
              mode = "n";
              keys = "g";
            };
            "__unkeyed-4" = {
              mode = "x";
              keys = "g";
            };

            "__unkeyed-5" = {
              mode = "n";
              keys = "<C-w>";
            };

            "__unkeyed-6" = {
              mode = "n";
              keys = "z";
            };
            "__unkeyed-7" = {
              mode = "x";
              keys = "z";
            };
          };

          clues = {
            "__unkeyed-1".__raw = "require('mini.clue').gen_clues.builtin_completion()";
            "__unkeyed-2".__raw = "require('mini.clue').gen_clues.g()";
            "__unkeyed-3".__raw = "require('mini.clue').gen_clues.marks()";
            "__unkeyed-4".__raw = "require('mini.clue').gen_clues.registers()";
            "__unkeyed-5".__raw = "require('mini.clue').gen_clues.windows()";
            "__unkeyed-6".__raw = "require('mini.clue').gen_clues.z()";
          };

          window.config.width = "auto";
        };

        # Align/justify blocks of text with ga or gA
        align = { };

        # Toggle comments with gc, or gcc for current line
        comment = { };
      };
    })
  ];
}
