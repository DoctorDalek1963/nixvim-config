{
  flake.nixvimModules.matchup = {
    # Make matching tags like () [] {} "" '' work better
    plugins.vim-matchup = {
      enable = true;
      settings.matchparen_offscreen = {
        method = "popup";
        scrolloff = 1;
      };
    };
  };
}
