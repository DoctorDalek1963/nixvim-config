{ self, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.auto-dark-mode = pkgs.vimUtils.buildVimPlugin {
        pname = "auto-dark-mode";
        version = "0.0.0-54058b4";

        src = pkgs.fetchFromGitHub {
          owner = "f-person";
          repo = "auto-dark-mode.nvim";
          rev = "54058b4fe414bd64bd2904a6f8a63f1f14e3d8df";
          hash = "sha256-xTgRyct3L6Gcz/vdYSc+h2IUgi/+Lh1Q4mxJwHISeis=";
        };
      };
    };

  flake.nixvimModules.auto-dark-mode =
    { pkgs, ... }:
    {
      extraPlugins = [ self.packages.${pkgs.stdenv.hostPlatform.system}.auto-dark-mode ];

      extraConfigLua = ''
        require('auto-dark-mode').setup()
      '';

      # The test for auto-dark-mode fails because it can't find dbus-send on PATH,
      # but that's normally available in the environment, not provisioned by nvim
      test.extraInputs = [
        pkgs.dbus
      ];
    };
}
