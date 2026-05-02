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

      nightly = {
        package = inputs.neovim-nightly-overlay.packages.${system}.default;
      };
    in
    {
      nixvimConfigurations = {
        nvim-tiny = evalNixvim {
          modules = [ self.nixvimModules.nvim-tiny ];
          inherit system;
        };
        nvim-small = evalNixvim {
          modules = [ self.nixvimModules.nvim-small ];
          inherit system;
        };
        nvim-medium = evalNixvim {
          modules = [ self.nixvimModules.nvim-medium ];
          inherit system;
        };
        nvim-full = evalNixvim {
          modules = [ self.nixvimModules.nvim-full ];
          inherit system;
        };

        nvim-tiny-nightly = evalNixvim {
          modules = [
            self.nixvimModules.nvim-tiny
            nightly
          ];
          inherit system;
        };
        nvim-small-nightly = evalNixvim {
          modules = [
            self.nixvimModules.nvim-small
            nightly
          ];
          inherit system;
        };
        nvim-medium-nightly = evalNixvim {
          modules = [
            self.nixvimModules.nvim-medium
            nightly
          ];
          inherit system;
        };
        nvim-full-nightly = evalNixvim {
          modules = with self.nixvimModules; [
            nvim-full
            nightly
          ];
          inherit system;
        };
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
          module.imports = [
            self.nixvimModules.nvim-tiny
            nightly
          ];
        };
        nvim-small-nightly = mkTestDerivationFromNixvimModule {
          module.imports = [
            self.nixvimModules.nvim-small
            nightly
          ];
        };
        nvim-medium-nightly = mkTestDerivationFromNixvimModule {
          module.imports = [
            self.nixvimModules.nvim-medium
            nightly
          ];
        };
        nvim-full-nightly = mkTestDerivationFromNixvimModule {
          module.imports = [
            self.nixvimModules.nvim-full
            nightly
          ];
        };
      };
    };
}
