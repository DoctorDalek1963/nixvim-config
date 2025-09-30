{ lib, ... }:
let
  inherit (lib) mkOption types;

  boolOpt = mkOption { type = types.bool; };

  defaultTrue = mkOption {
    default = true;
    type = types.bool;
  };
  defaultFalse = mkOption {
    default = false;
    type = types.bool;
  };
in
{
  imports = [
    ./modules/core.nix

    ./modules/autoCmdGroups.nix
    ./modules/filetypes.nix
    ./modules/keymaps.nix
    ./modules/options.nix

    ./modules/lang
    ./modules/plugins
  ];

  options.setup = {
    useNightly = defaultFalse;

    pluginGroups = {
      base = defaultTrue;
      niceToHave = defaultFalse;
      programming = defaultFalse;
    };

    lang = {
      enable = defaultTrue;

      nix = defaultTrue;

      c_cpp = boolOpt;
      configFiles = boolOpt;
      dlang = boolOpt;
      dockerfile = boolOpt;
      elixir = boolOpt;
      haskell = boolOpt;
      julia = boolOpt;
      jvm = boolOpt;
      latex = boolOpt;
      lean4 = boolOpt;
      lua = boolOpt;
      python = boolOpt;
      rust = boolOpt;
      shell = boolOpt;
      webDev = boolOpt;
      zig = boolOpt;
    };
  };
}
