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

    nvim-tiny-nightly.imports = with self.nixvimModules; [
      nvim-tiny
      nightly
    ];
    nvim-small-nightly.imports = with self.nixvimModules; [
      nvim-small
      nightly
    ];
    nvim-medium-nightly.imports = with self.nixvimModules; [
      nvim-medium
      nightly
    ];
    nvim-full-nightly.imports = with self.nixvimModules; [
      nvim-full
      nightly
    ];
  };
}
