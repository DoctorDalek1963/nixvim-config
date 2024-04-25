{
  description = "DoctorDalek1963's nixvim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay?rev=22225800f7c24e7460026a5b6c9c94187d67555f";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
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

      perSystem = {
        pkgs,
        system,
        ...
      }: let
        nixvimLib = nixvim.lib.${system};
        nixvim' = nixvim.legacyPackages.${system};

        mkNixvimModule = extraSpecialArgs @ {
          # I know these are all unused here, but they're used as the
          # extraSpecialArgs and having them explicitly defined here makes all
          # the options obvious
          dapDebugger,
          cLsps,
          configFileLsps,
          dockerfileLsp,
          haskellLsp,
          juliaLsp,
          jvmLsps,
          latexLsp,
          luaLsp,
          pythonLsp,
          rustLsp,
          shellLsps,
          webLsps,
        }
        : {
          # Change this back to `inherit pkgs;` to return to stable nvim
          pkgs = import nixpkgs {
            inherit system;
            overlays = [inputs.neovim-nightly-overlay.overlay];
          };
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
            haskellLsp = false;
            juliaLsp = false;
            jvmLsps = false;
            latexLsp = false;
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
            haskellLsp = false;
            juliaLsp = false;
            jvmLsps = false;
            latexLsp = true;
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
            haskellLsp = true;
            juliaLsp = true;
            jvmLsps = true;
            latexLsp = true;
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
      };
    };
}
