{
  flake.nixvimModules.oil = {
    plugins = {
      oil = {
        enable = true;
        settings = {
          default_file_explorer = true;
          experimental_watch_for_changes = true;
          prompt_save_on_select_new_entry = true;
          skip_confirm_for_simple_edits = false;
          view_options.show_hidden = true;

          win_options.signcolumn = "auto:1-2";

          columns = [
            {
              __unkeyed = "size";
              highlight = "Special";
            }
            "icon"
          ];

          keymaps = {
            ";" = "actions.select";
            "<C-l>" = false;
            "<C-h>" = false;
            "<C-r>" = "actions.refresh";
          };
        };
      };

      oil-git-status = {
        enable = true;

        settings = {
          # Use the same symbols that I use in my Starship prompt
          symbols = {
            index = {
              "!" = "I"; # Ignored
              "?" = "%"; # Untracked
              "A" = "+"; # Added
              "C" = "+"; # Copied
              "D" = "-"; # Deleted
              "M" = "+"; # Modified
              "R" = "~"; # Renamed
              "T" = "T"; # Type changed
              "U" = "!"; # Unmerged
              " " = " ";
            };

            working_tree = {
              "!" = "I"; # Ignored
              "?" = "%"; # Untracked
              "A" = "*"; # Added
              "C" = "*"; # Copied
              "D" = "-"; # Deleted
              "M" = "*"; # Modified
              "R" = "~"; # Renamed
              "T" = "T"; # Type changed
              "U" = "!"; # Unmerged
              " " = " ";
            };
          };
        };
      };
    };

    keymaps = [
      {
        key = "<leader>o";
        action.__raw = "require('oil').open";
        mode = "n";
        options.desc = "Open oil";
      }
    ];
  };
}
