# { inputs, ... }:
{
  # perSystem =
  #   {
  #     pkgs,
  #     system,
  #     ...
  #   }:
  #   let
  #     nixvim' = inputs.nixvim.legacyPackages.${system};
  #
  #     mkModuleArgs = configName: {
  #       inherit pkgs;
  #       module = (import ./defs.nix)."${configName}";
  #       extraSpecialArgs = { inherit inputs; };
  #     };
  #   in
  #   rec {
  #     packages = rec {
  #       default = nvim-medium;
  #
  #       nvim-tiny = nixvim'.makeNixvimWithModule (mkModuleArgs "tiny");
  #       nvim-small = nixvim'.makeNixvimWithModule (mkModuleArgs "small");
  #       nvim-medium = nixvim'.makeNixvimWithModule (mkModuleArgs "medium");
  #       nvim-full = nixvim'.makeNixvimWithModule (mkModuleArgs "full");
  #
  #       nvim-tiny-nightly = nvim-tiny.extend { setup.useNightly = true; };
  #       nvim-small-nightly = nvim-small.extend { setup.useNightly = true; };
  #       nvim-medium-nightly = nvim-medium.extend { setup.useNightly = true; };
  #       nvim-full-nightly = nvim-full.extend { setup.useNightly = true; };
  #     };
  #
  #     checks =
  #       let
  #         check =
  #           name:
  #           inputs.nixvim.lib.${system}.check.mkTestDerivationFromNvim {
  #             inherit name;
  #             nvim = packages."${name}";
  #           };
  #       in
  #       {
  #         tiny = check "nvim-tiny";
  #         small = check "nvim-small";
  #         medium = check "nvim-medium";
  #         full = check "nvim-full";
  #
  #         tiny-nightly = check "nvim-tiny-nightly";
  #         small-nightly = check "nvim-small-nightly";
  #         medium-nightly = check "nvim-medium-nightly";
  #         full-nightly = check "nvim-full-nightly";
  #       };
  #   };
}
