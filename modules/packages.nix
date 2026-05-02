{ self, inputs, ... }:
{
  perSystem =
    {
      self',
      system,
      ...
    }:
    let
      nixvim' = inputs.nixvim.legacyPackages.${system};

      mkNightly =
        nvim:
        nvim.extend {
          package = inputs.neovim-nightly-overlay.packages.${system}.default;
        };
    in
    {
      packages = {
        default = self'.packages.nvim-medium;

        nvim-tiny = nixvim'.makeNixvim {
          imports = with self.nixvimModules; [
            core
            plugin-group-base
          ];
        };

        nvim-small = nixvim'.makeNixvim {
          imports = with self.nixvimModules; [
            core
            plugin-group-comfortable
          ];
        };

        nvim-medium = nixvim'.makeNixvim {
          imports = with self.nixvimModules; [
            core
            plugin-group-programming
          ];
        };

        nvim-full = nixvim'.makeNixvim {
          imports = with self.nixvimModules; [
            core
            plugin-group-programming
          ];
        };

        nvim-tiny-nightly = mkNightly self'.packages.nvim-tiny;
        nvim-small-nightly = mkNightly self'.packages.nvim-small;
        nvim-medium-nightly = mkNightly self'.packages.nvim-medium;
        nvim-full-nightly = mkNightly self'.packages.nvim-full;
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
