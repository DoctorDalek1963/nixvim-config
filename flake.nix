{
  description = "DoctorDalek1963's nixvim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";

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

      imports = [
        inputs.pre-commit-hooks.flakeModule
      ];

      perSystem = {
        pkgs,
        config,
        system,
        ...
      }: let
        nixvimLib = nixvim.lib.${system};
        nixvim' = nixvim.legacyPackages.${system};

        # I know these are all unused here, but they're used as the
        # extraSpecialArgs and having them explicitly defined here makes all
        # the options obvious
        mkNixvimModule = extraSpecialArgs @ {
          # deadnix: skip
          dapDebugger,
          # deadnix: skip
          cLsps,
          # deadnix: skip
          configFileLsps,
          # deadnix: skip
          dockerfileLsp,
          # deadnix: skip
          elixirLsp,
          # deadnix: skip
          haskellLsp,
          # deadnix: skip
          juliaLsp,
          # deadnix: skip
          jvmLsps,
          # deadnix: skip
          latexLsp,
          # deadnix: skip
          leanNvim,
          # deadnix: skip
          luaLsp,
          # deadnix: skip
          pythonLsp,
          # deadnix: skip
          rustLsp,
          # deadnix: skip
          shellLsps,
          # deadnix: skip
          webLsps,
        }
        : {
          inherit pkgs;
          module = import ./config;
          inherit extraSpecialArgs;
        };

        # Small has almost no LSPs (except nixd) and no debugging
        # Medium is for my day-to-day programming
        # Full contains all the LSPs I could want
        nixvimModules = {
          small = mkNixvimModule {
            dapDebugger = false;
            cLsps = false;
            configFileLsps = false;
            dockerfileLsp = false;
            elixirLsp = false;
            haskellLsp = false;
            juliaLsp = false;
            jvmLsps = false;
            latexLsp = false;
            leanNvim = false;
            luaLsp = false;
            pythonLsp = false;
            rustLsp = false;
            shellLsps = false;
            webLsps = false;
          };
          medium = mkNixvimModule {
            dapDebugger = true;
            cLsps = false;
            configFileLsps = true;
            dockerfileLsp = false;
            elixirLsp = true;
            haskellLsp = false;
            juliaLsp = false;
            jvmLsps = false;
            latexLsp = true;
            leanNvim = true;
            luaLsp = true;
            pythonLsp = true;
            rustLsp = true;
            shellLsps = true;
            webLsps = false;
          };
          full = mkNixvimModule {
            dapDebugger = true;
            cLsps = true;
            configFileLsps = true;
            dockerfileLsp = true;
            elixirLsp = true;
            haskellLsp = true;
            juliaLsp = true;
            jvmLsps = true;
            latexLsp = true;
            leanNvim = true;
            luaLsp = true;
            pythonLsp = true;
            rustLsp = true;
            shellLsps = true;
            webLsps = true;
          };
        };

        nvim-small = nixvim'.makeNixvimWithModule nixvimModules.small;
        nvim-medium = nixvim'.makeNixvimWithModule nixvimModules.medium;
        nvim-full = nixvim'.makeNixvimWithModule nixvimModules.full;
      in {
        checks = {
          small = nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModules.small;
          medium = nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModules.medium;
          full = nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModules.full;
        };

        packages = {
          default = nvim-medium;
          inherit nvim-small nvim-medium nvim-full;
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
          };
        };
      };
    };
}
