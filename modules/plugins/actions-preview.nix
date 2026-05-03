{
  flake.nixvimModules.actions-preview =
    { pkgs, lib, ... }:
    {
      plugins = {
        actions-preview = {
          enable = true;

          settings = {
            highlight_command = [
              (lib.nixvim.mkRaw "require('actions-preview.highlight').delta '${lib.getExe pkgs.delta} --no-gitconfig --side-by-side'")
            ];

            backend = [ "nui" ];
          };

          lazyLoad.settings.keys = [ "<M-return>" ];
        };

        nui.enable = true;

        lz-n.keymaps = [
          {
            plugin = "actions-preview";
            key = "<M-return>";
            action.__raw = "function() require('actions-preview').code_actions() end";
            mode = "n";
            options = {
              silent = true;
              desc = "Open code actions with preview";
            };
          }
        ];
      };
    };
}
