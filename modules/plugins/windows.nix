{
  pkgs,
  lib,
  config,
  ...
}:
{
  config = lib.mkIf config.setup.pluginGroups.niceToHave {
    extraPlugins = [ pkgs.vimPlugins.windows-nvim ];

    extraConfigLua = ''
      require("windows").setup()
    '';

    opts = {
      winwidth = 15;
      winminwidth = 0;
      equalalways = false;
    };

    keymaps = [
      {
        key = "<C-w><C-w>";
        action = "<cmd>WindowsMaximize<cr>";
        mode = "n";
        options = {
          silent = true;
          desc = "Toggle maximise the current window";
        };
      }
    ];
  };
}
