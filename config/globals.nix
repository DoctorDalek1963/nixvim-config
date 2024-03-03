let
  baseGlobals = {
    mapleader = "\\";
    maplocalleader = "\\";
  };
  pluginGlobals = {
    # vimtex
    vimtex_view_general_viewer = "evince";
    vimtex_syntax_conceal_disable = 1;
  };
in {
  globals = baseGlobals // pluginGlobals;
}
