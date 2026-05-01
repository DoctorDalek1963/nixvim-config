{ inputs, ... }:
{
  flake-file = {
    description = "DoctorDalek1963's nixvim configuration";

    inputs = {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
      flake-parts.url = "github:hercules-ci/flake-parts";
    };
  };

  imports = [
    inputs.flake-file.flakeModules.dendritic
  ];

  systems = [
    "x86_64-linux"
    "aarch64-linux"
    "x86_64-darwin"
    "aarch64-darwin"
  ];
}
