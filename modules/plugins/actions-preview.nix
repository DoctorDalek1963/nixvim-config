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
        };

        nui.enable = true;
      };

      keymaps = [
        {
          key = "<M-return>";
          action.__raw = "require('actions-preview').code_actions";
          mode = "n";
          options = {
            silent = true;
            desc = "Open code actions with preview";
          };
        }
      ];
    };
}
