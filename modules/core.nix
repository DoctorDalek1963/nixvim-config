{
  pkgs,
  lib,
  inputs,
  config,
  ...
}:
{
  assertions = [
    {
      assertion = config.setup.pluginGroups.niceToHave -> config.setup.pluginGroups.base;
      message = "pluginGroups.niceToHave requires pluginGroups.base";
    }
    {
      assertion = config.setup.pluginGroups.programming -> config.setup.pluginGroups.niceToHave;
      message = "pluginGroups.programming requires pluginGroups.niceToHave";
    }
  ];

  package =
    lib.mkIf config.setup.useNightly
      inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default;

  enableMan = false;

  performance.byteCompileLua = {
    enable = true;
    configs = true;
    initLua = true;
    nvimRuntime = true;
    plugins = true;
  };

  colorschemes.catppuccin = {
    enable = true;
    settings = {
      flavour = "macchiato";
      background = {
        light = "latte";
        dark = "macchiato";
      };
      dimInactive = {
        enabled = true;
        percentage = 0.15;
      };
      integrations = {
        cmp = true;
        gitgutter = true;
        rainbow_delimiters = true;
        treesitter = true;
        treesitter_context = true;
        dap = {
          enabled = true;
          enable_ui = true;
        };
        indent_blankline = {
          enabled = true;
          colored_indent_levels = true;
        };
        native_lsp = true;
        telescope = true;
      };
    };
  };

  userCommands = {
    Rmsp = {
      desc = "Remove all trailing spaces";
      command = "execute '%s/\\s\\+$//e'";
    };
  };

  globals = {
    mapleader = "\\";
    maplocalleader = "\\";
  };
}
