{ inputs, ... }:

{
  flake-file.inputs = {
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  imports = [
    inputs.pre-commit-hooks.flakeModule
  ];

  perSystem =
    { pkgs, config, ... }:
    {
      devShells.default = pkgs.mkShell {
        nativeBuildInputs = [
          pkgs.just
        ];

        shellHook = ''
          ${config.pre-commit.installationScript}
        '';
      };

      # See https://flake.parts/options/git-hooks-nix and
      # https://github.com/cachix/git-hooks.nix/blob/master/modules/hooks.nix
      # for all the available hooks and options
      pre-commit = {
        # One of the hooks runs `nix flake check` on this flake, so we don't
        # want to recurse infinitely
        check.enable = false;

        settings.hooks = {
          check-added-large-files.enable = true;
          check-merge-conflicts.enable = true;
          check-toml.enable = true;
          check-vcs-permalinks.enable = true;
          check-yaml.enable = true;
          end-of-file-fixer.enable = true;

          trim-trailing-whitespace = {
            enable = true;
            excludes = [ ''.+\.patch$'' ];
          };

          nixfmt-rfc-style = {
            enable = true;
            package = pkgs.nixfmt;
          };

          deadnix.enable = true;
          statix.enable = true;

          flake-check = {
            enable = false;
            entry = "nix flake check";
            stages = [ "pre-push" ];
            pass_filenames = false;
          };
        };
      };
    };
}
