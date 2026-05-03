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
      haskell
      json
      just
      latex
      nix
      python
      rust
      toml
      yaml
      zig
    ];

    nvim-full.imports = with self.nixvimModules; [
      plugin-group-programming

      bash
      c_cpp
      clojure
      css
      # d
      docker
      elixir
      haskell
      html
      java
      json
      julia
      just
      kotlin
      latex
      lean4
      lua
      nix
      python
      rust
      scala
      toml
      typescript
      xml
      yaml
      zig
    ];
  };
}
