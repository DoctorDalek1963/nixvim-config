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
    { system, lib, ... }:
    let
      nvim-modules = lib.filterAttrs (
        name: _: (builtins.substring 0 5 name) == "nvim-"
      ) self.nixvimModules;
    in
    {
      nixvimConfigurations = builtins.mapAttrs (
        _: module:
        inputs.nixvim.lib.evalNixvim {
          inherit system;
          modules = [ module ];
        }
      ) nvim-modules;

      packages = lib.mapAttrs (_: conf: conf.config.build.package) self.nixvimConfigurations.${system};

      checks = builtins.mapAttrs (
        _: module:
        inputs.nixvim.lib.${system}.check.mkTestDerivationFromNixvimModule {
          inherit module;
        }
      ) nvim-modules;
    };
}
