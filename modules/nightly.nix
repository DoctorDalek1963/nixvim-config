{ self, inputs, ... }:
{
  flake.nixvimModules = {
    nightly =
      { pkgs, ... }:
      {
        package = inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default;
      };

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
