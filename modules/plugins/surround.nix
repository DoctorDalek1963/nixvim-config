{
  flake.nixvimModules.surround = {
    # Handle delimiters like () [] {} "" '' better
    plugins.vim-surround.enable = true;
  };
}
