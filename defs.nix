{
  # Tiny has no LSPs or debugging at all
  tiny = {
    imports = [./setup.nix];
    setup = {
      tools.dapDebugger = false;

      lang = {
        enable = false;
        nix = false;

        elixir = false;
        latex = false;
        rust = false;
      };
    };
  };

  # Small has almost no LSPs (except nixd) and no debugging
  small = {
    imports = [./setup.nix];
    setup = {
      tools.dapDebugger = false;

      lang = {
        elixir = false;
        latex = false;
        rust = false;
      };
    };
  };

  # Medium is for my day-to-day programming
  medium = {
    imports = [./setup.nix];
    setup = {
      tools.dapDebugger = true;

      lang = {
        elixir = true;
        latex = true;
        rust = true;
      };
    };
  };

  # Full contains all the LSPs I could want
  full = {
    imports = [./setup.nix];
    setup = {
      tools.dapDebugger = false;

      lang = {
        elixir = true;
        latex = true;
        rust = true;
      };
    };
  };
}
