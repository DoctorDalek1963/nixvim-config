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
    ];

    nvim-full.imports = with self.nixvimModules; [
      core
      plugin-group-programming
    ];
  };
}
