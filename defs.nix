{
  # Tiny has no LSPs or debugging at all
  tiny = {lib, ...}: {
    imports = [./setup.nix];
    setup = {
      lang = {
        enable = lib.mkDefault false;
        nix = lib.mkDefault false;

        c_cpp = lib.mkDefault false;
        configFiles = lib.mkDefault false;
        dockerfile = lib.mkDefault false;
        elixir = lib.mkDefault false;
        haskell = lib.mkDefault false;
        julia = lib.mkDefault false;
        jvm = lib.mkDefault false;
        latex = lib.mkDefault false;
        lean4 = lib.mkDefault false;
        lua = lib.mkDefault false;
        python = lib.mkDefault false;
        rust = lib.mkDefault false;
        shell = lib.mkDefault false;
        webDev = lib.mkDefault false;
      };
    };
  };

  # Small has very few LSPs and no debugging
  small = {lib, ...}: {
    imports = [./setup.nix];
    setup = {
      pluginGroups.niceToHave = lib.mkDefault true;

      lang = {
        c_cpp = lib.mkDefault false;
        configFiles = lib.mkDefault true;
        dockerfile = lib.mkDefault false;
        elixir = lib.mkDefault false;
        haskell = lib.mkDefault false;
        julia = lib.mkDefault false;
        jvm = lib.mkDefault false;
        latex = lib.mkDefault false;
        lean4 = lib.mkDefault false;
        lua = lib.mkDefault false;
        python = lib.mkDefault false;
        rust = lib.mkDefault false;
        shell = lib.mkDefault true;
        webDev = lib.mkDefault false;
      };
    };
  };

  # Medium is for my day-to-day programming
  medium = {lib, ...}: {
    imports = [./setup.nix];
    setup = {
      pluginGroups = {
        niceToHave = lib.mkDefault true;
        programming = lib.mkDefault true;
      };

      lang = {
        c_cpp = lib.mkDefault false;
        configFiles = lib.mkDefault true;
        dockerfile = lib.mkDefault false;
        elixir = lib.mkDefault true;
        haskell = lib.mkDefault false;
        julia = lib.mkDefault false;
        jvm = lib.mkDefault false;
        latex = lib.mkDefault true;
        lean4 = lib.mkDefault true;
        lua = lib.mkDefault false;
        python = lib.mkDefault true;
        rust = lib.mkDefault true;
        shell = lib.mkDefault true;
        webDev = lib.mkDefault false;
      };
    };
  };

  # Full contains all the LSPs I could want
  full = {lib, ...}: {
    imports = [./setup.nix];
    setup = {
      pluginGroups = {
        niceToHave = lib.mkDefault true;
        programming = lib.mkDefault true;
      };

      lang = {
        c_cpp = lib.mkDefault true;
        configFiles = lib.mkDefault true;
        dockerfile = lib.mkDefault true;
        elixir = lib.mkDefault true;
        haskell = lib.mkDefault true;
        julia = lib.mkDefault true;
        jvm = lib.mkDefault true;
        latex = lib.mkDefault true;
        lean4 = lib.mkDefault true;
        lua = lib.mkDefault true;
        python = lib.mkDefault true;
        rust = lib.mkDefault true;
        shell = lib.mkDefault true;
        webDev = lib.mkDefault true;
      };
    };
  };
}
