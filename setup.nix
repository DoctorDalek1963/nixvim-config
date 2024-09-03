{lib, ...}: let
  inherit (lib) mkOption types;
  # boolOpt = mkOption {type = types.bool;};
in {
  imports = [
    ./modules/core.nix

    ./modules/autoCmdGroups.nix
    ./modules/filetypes.nix
    ./modules/keymaps.nix
    ./modules/options.nix
  ];

  options.setup = {
    useNightly = mkOption {
      default = false;
      type = types.bool;
    };

    # tools = {
    #   dapDebugger = boolOpt;
    #   leanNvim = boolOpt;
    # };

    lsp = {
      # c_cpp = boolOpt;
      # configFiles = boolOpt;
      # dockerfile = boolOpt;
      # elixir = boolOpt;
      # haskell = boolOpt;
      # julia = boolOpt;
      # jvm = boolOpt;
      # latex = boolOpt;
      # lua = boolOpt;
      # python = boolOpt;
      # rust = boolOpt;
      # shell = boolOpt;
      # webDev = boolOpt;

      nix = mkOption {
        type = types.bool;
        default = true;
      };
    };
  };
}
