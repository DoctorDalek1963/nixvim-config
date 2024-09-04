{
  # Tiny has no LSPs or debugging at all
  tiny = {
    imports = [./setup.nix];
    setup = {
      lsp.enable = false;
    };
  };

  # Small has almost no LSPs (except nixd) and no debugging
  small = {
    imports = [./setup.nix];
    setup = {};
  };

  # Medium is for my day-to-day programming
  medium = {
    imports = [./setup.nix];
    setup = {};
  };

  # Full contains all the LSPs I could want
  full = {
    imports = [./setup.nix];
    setup = {};
  };
}
