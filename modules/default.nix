{ self, ... }:
{
  perSystem =
    { self', ... }:
    {
      packages.default = self'.packages.nvim-medium;
    };

  flake.nixvimModules = {
    nvim-tiny.imports = with self.nixvimModules; [
      plugin-group-base
    ];

    nvim-small.imports = with self.nixvimModules; [
      plugin-group-comfortable
    ];

    nvim-medium.imports = with self.nixvimModules; [
      plugin-group-programming

      bash
      c_cpp
      haskell
      latex
      nix
      python
      rust
      zig
    ];

    nvim-full.imports = with self.nixvimModules; [
      plugin-group-programming

      bash
      c_cpp
      clojure
      d
      docker
      elixir
      haskell
      java
      julia
      kotlin
      latex
      lean4
      lua
      nix
      python
      rust
      scala
      zig
    ];
  };
}
