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
    {
      nixvimConfigurations =
        let
          inherit (inputs.nixvim.lib) evalNixvim;

          nightly = {
            package = inputs.neovim-nightly-overlay.packages.${system}.default;
          };
        in
        {
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

      checks =
        let
          check =
            name:
            inputs.nixvim.lib.${system}.check.mkTestDerivationFromNvim {
              inherit name;
              nvim = self'.packages."${name}";
            };
        in
        {
          tiny = check "nvim-tiny";
          small = check "nvim-small";
          medium = check "nvim-medium";
          full = check "nvim-full";

          tiny-nightly = check "nvim-tiny-nightly";
          small-nightly = check "nvim-small-nightly";
          medium-nightly = check "nvim-medium-nightly";
          full-nightly = check "nvim-full-nightly";
        };
    };
}
