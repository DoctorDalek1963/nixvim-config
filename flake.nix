{
  description = "DoctorDalek1963's nixvim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixvim,
    flake-parts,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      imports = [inputs.pre-commit-hooks.flakeModule];

      perSystem = {
        pkgs,
        config,
        system,
        ...
      }: let
        nixvim' = nixvim.legacyPackages.${system};

        mkModuleArgs = configName: {
          inherit pkgs;
          module = (import ./defs.nix)."${configName}";
          extraSpecialArgs = {inherit inputs;};
        };
      in rec {
        packages = rec {
          default = nvim-medium;

          nvim-tiny = nixvim'.makeNixvimWithModule (mkModuleArgs "tiny");
          nvim-small = nixvim'.makeNixvimWithModule (mkModuleArgs "small");
          nvim-medium = nixvim'.makeNixvimWithModule (mkModuleArgs "medium");
          nvim-full = nixvim'.makeNixvimWithModule (mkModuleArgs "full");

          nvim-tiny-nightly = nvim-tiny.extend {setup.useNightly = true;};
          nvim-small-nightly = nvim-small.extend {setup.useNightly = true;};
          nvim-medium-nightly = nvim-medium.extend {setup.useNightly = true;};
          nvim-full-nightly = nvim-full.extend {setup.useNightly = true;};
        };

        checks = let
          check = name:
            nixvim.lib.${system}.check.mkTestDerivationFromNvim {
              inherit name;
              nvim = packages."${name}";
            };
        in {
          tiny = check "nvim-tiny";
          small = check "nvim-small";
          medium = check "nvim-medium";
          full = check "nvim-full";

          tiny-nightly = check "nvim-tiny-nightly";
          small-nightly = check "nvim-small-nightly";
          medium-nightly = check "nvim-medium-nightly";
          full-nightly = check "nvim-full-nightly";
        };

        devShells.default = pkgs.mkShell {
          shellHook = ''
            ${config.pre-commit.installationScript}
          '';
        };

        # See https://flake.parts/options/pre-commit-hooks-nix and
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
            trim-trailing-whitespace.enable = true;

            alejandra.enable = true;
            deadnix.enable = true;
            statix.enable = true;

            flake-check = {
              enable = true;
              entry = "nix flake check";
              stages = ["pre-push"];
              pass_filenames = false;
            };
          };
        };
      };
    };
}
