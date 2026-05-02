{ inputs, ... }:
{
  flake.nixvimModules.nightly =
    { pkgs, ... }:
    {
      package = inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default;
    };
}
