{
  flake.nixvimModules.mini-ai = {
    # Improve text objects, not LLM
    plugins.mini = {
      enable = true;

      modules.ai = {
        n_lines = 200;
      };
    };
  };
}
