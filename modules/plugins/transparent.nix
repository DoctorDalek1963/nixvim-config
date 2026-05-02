{
  flake.nixvimModules.transparent = {
    plugins.transparent = {
      enable = true;
      settings.extra_groups = [ "NormalFloat" ];
    };

    globals.transparent_enabled = true;

    keymaps = [
      {
        key = "<leader>tt";
        action = "<cmd>TransparentToggle<cr>";
        mode = "n";
        options.desc = "Toggle transparency";
      }
    ];
  };
}
