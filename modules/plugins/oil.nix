{
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.setup.pluginGroups.niceToHave {
    plugins.oil = {
      enable = true;
      settings = {
        default_file_explorer = true;
        experimental_watch_for_changes = true;
        prompt_save_on_select_new_entry = true;
        skip_confirm_for_simple_edits = false;

        columns = [
          {
            __unkeyed = "size";
            highlight = "Special";
          }
          "icon"
        ];

        view_options.show_hidden = true;
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
