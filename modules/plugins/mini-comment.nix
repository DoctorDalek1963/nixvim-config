{
  flake.nixvimModules.mini-comment = {
    # Toggle comments with gc, or gcc for current line
    plugins.mini = {
      enable = true;

      modules.comment = { };
    };
  };
}
