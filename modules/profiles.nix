{ self, ... }:
{
  flake.nixvimModules = {
    nvim-tiny.imports = with self.nixvimModules; [
      core
      plugin-group-base
    ];

    nvim-small.imports = with self.nixvimModules; [
      core
      plugin-group-comfortable
    ];

    nvim-medium.imports = with self.nixvimModules; [
      core
      plugin-group-programming
    ];

    nvim-full.imports = with self.nixvimModules; [
      core
      plugin-group-programming
    ];
  };
}
