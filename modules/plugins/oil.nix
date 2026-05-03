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
          };
        };

        lazyLoad.settings.keys = [ "<leader>o" ];

        luaConfig.post = ''
          require('lz.n').trigger_load('oil-git-status')
        '';
      };

      oil-git-status = {
        enable = true;
        lazyLoad.settings.lazy = true;
      };

      lz-n.keymaps = [
        {
          plugin = "oil";
          key = "<leader>o";
          action.__raw = "function() require('oil').open() end";
          mode = "n";
          options.desc = "Open oil";
        }
      ];
    };
  };
}
