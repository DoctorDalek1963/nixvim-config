{
  # Tiny has no LSPs or debugging at all
  tiny = {
    imports = [./setup.nix];
    setup = {
      tools.dapDebugger = false;

      lang = {
        enable = false;
        nix = false;

        c_cpp = false;
        configFiles = false;
        dockerfile = false;
        elixir = false;
        haskell = false;
        julia = false;
        jvm = false;
        latex = false;
        lean4 = false;
        lua = false;
        python = false;
        rust = false;
        shell = false;
        webDev = false;
      };
    };
  };

  # Small has very few LSPs and no debugging
  small = {
    imports = [./setup.nix];
    setup = {
      tools.dapDebugger = false;

      lang = {
        c_cpp = false;
        configFiles = true;
        dockerfile = false;
        elixir = false;
        haskell = false;
        julia = false;
        jvm = false;
        latex = false;
        lean4 = false;
        lua = false;
        python = false;
        rust = false;
        shell = true;
        webDev = false;
      };
    };
  };

  # Medium is for my day-to-day programming
  medium = {
    imports = [./setup.nix];
    setup = {
      tools.dapDebugger = true;

      lang = {
        c_cpp = false;
        configFiles = true;
        dockerfile = false;
        elixir = true;
        haskell = false;
        julia = false;
        jvm = false;
        latex = true;
        lean4 = true;
        lua = false;
        python = true;
        rust = true;
        shell = true;
        webDev = false;
      };
    };
  };

  # Full contains all the LSPs I could want
  full = {
    imports = [./setup.nix];
    setup = {
      tools.dapDebugger = true;

      lang = {
        c_cpp = true;
        configFiles = true;
        dockerfile = true;
        elixir = true;
        haskell = true;
        julia = true;
        jvm = true;
        latex = true;
        lean4 = true;
        lua = true;
        python = true;
        rust = true;
        shell = true;
        webDev = true;
      };
    };
  };
}
