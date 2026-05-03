{ self, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.vim-nixhash = pkgs.vimUtils.buildVimPlugin {
        pname = "vim-nixhash";
        version = "0.0.0-1ba23ac";

        src = pkgs.fetchFromGitHub {
          owner = "symphorien";
          repo = "vim-nixhash";
          rev = "1ba23accf365f557b713ef625888a8b6b9d2f806";
          hash = "sha256-MWLc3ezCx7cG/HASghB4y7BwmFQq/r6sdKDIWTlihw4=";
        };
      };
    };

  flake.nixvimModules.nix =
    { pkgs, ... }:
    {
      lsp.servers.nixd = {
        enable = true;
        config.formatting.command = null;
      };

      plugins.none-ls = {
        sources = {
          code_actions.statix.enable = true;
          diagnostics = {
            deadnix.enable = true;
            statix.enable = true;
          };
          formatting.nixfmt = {
            enable = true;
            package = pkgs.nixfmt;
          };

        };

        lazyLoad.settings.ft = [ "nix" ];
      };

      extraPlugins = [ self.packages.${pkgs.stdenv.hostPlatform.system}.vim-nixhash ];
    };
}
