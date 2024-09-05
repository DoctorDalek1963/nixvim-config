{lib, ...}: let
  inherit (lib) mkOption types;

  boolOpt = mkOption {type = types.bool;};

  defaultTrue = mkOption {
    default = true;
    type = types.bool;
  };
  defaultFalse = mkOption {
    default = false;
    type = types.bool;
  };
in {
  imports = [
    ./modules/core.nix

    ./modules/autoCmdGroups.nix
    ./modules/filetypes.nix
    ./modules/keymaps.nix
    ./modules/options.nix

    ./modules/plugins
  ];

  options.setup = {
    useNightly = defaultFalse;

    # plugins = {};

    tools = {
      dapDebugger = boolOpt;
      # leanNvim = boolOpt;
    };

    lsp = {
      enable = defaultTrue;

      nix = defaultTrue;

      # c_cpp = boolOpt;
      # configFiles = boolOpt;
      # dockerfile = boolOpt;
      elixir = boolOpt;
      # haskell = boolOpt;
      # julia = boolOpt;
      # jvm = boolOpt;
      # latex = boolOpt;
      # lua = boolOpt;
      # python = boolOpt;
      rust = boolOpt;
      # shell = boolOpt;
      # webDev = boolOpt;
    };
  };
}
