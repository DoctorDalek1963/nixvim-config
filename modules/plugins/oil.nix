{
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.setup.pluginGroups.niceToHave {
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
          };
        };
      };

      oil-git-status.enable = true;
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
