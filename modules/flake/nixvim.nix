{ self, inputs, ... }:
{
  flake-file.inputs = {
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  imports = [
    inputs.nixvim.flakeModule
  ];

  perSystem =
    {
      self',
      system,
      lib,
      ...
    }:
    let
      inherit (inputs.nixvim.lib) evalNixvim;
      inherit (inputs.nixvim.lib.${system}.check) mkTestDerivationFromNixvimModule;

      evalNixvimModule =
        module:
        evalNixvim {
          inherit system;
          modules = [ module ];
        };
    in
    {
      nixvimConfigurations = {
        nvim-tiny = evalNixvimModule self.nixvimModules.nvim-tiny;
        nvim-small = evalNixvimModule self.nixvimModules.nvim-small;
        nvim-medium = evalNixvimModule self.nixvimModules.nvim-medium;
        nvim-full = evalNixvimModule self.nixvimModules.nvim-full;

        nvim-tiny-nightly = evalNixvimModule self.nixvimModules.nvim-tiny-nightly;
        nvim-small-nightly = evalNixvimModule self.nixvimModules.nvim-small-nightly;
        nvim-medium-nightly = evalNixvimModule self.nixvimModules.nvim-medium-nightly;
        nvim-full-nightly = evalNixvimModule self.nixvimModules.nvim-full-nightly;
      };

      packages =
        (lib.mapAttrs (_: conf: conf.config.build.package) self.nixvimConfigurations.${system})
        // {
          default = self'.packages.nvim-medium;
        };

      checks = {
        nvim-tiny = mkTestDerivationFromNixvimModule {
          module = self.nixvimModules.nvim-tiny;
        };
        nvim-small = mkTestDerivationFromNixvimModule {
          module = self.nixvimModules.nvim-small;
        };
        nvim-medium = mkTestDerivationFromNixvimModule {
          module = self.nixvimModules.nvim-medium;
        };
        nvim-full = mkTestDerivationFromNixvimModule {
          module = self.nixvimModules.nvim-full;
        };

        nvim-tiny-nightly = mkTestDerivationFromNixvimModule {
          module = self.nixvimModules.nvim-tiny-nightly;
        };
        nvim-small-nightly = mkTestDerivationFromNixvimModule {
          module = self.nixvimModules.nvim-small-nightly;
        };
        nvim-medium-nightly = mkTestDerivationFromNixvimModule {
          module = self.nixvimModules.nvim-medium-nightly;
        };
        nvim-full-nightly = mkTestDerivationFromNixvimModule {
          module = self.nixvimModules.nvim-full-nightly;
        };
      };
    };
}
