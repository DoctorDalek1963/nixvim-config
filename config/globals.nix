let
  baseGlobals = {
    mapleader = "\\";
    maplocalleader = "\\";
  };
  pluginGlobals = {
    # quick-scope
    qs_highlight_on_keys = ["f" "F" "t" "T"];

    # vimtex
    vimtex_view_general_viewer = "evince";
    vimtex_syntax_conceal_disable = 1;
  };
in {
  globals = baseGlobals // pluginGlobals;
}
