{
  lib,
  config,
  ...
}: let
  cfg = config.setup.lang;
in {
  config = lib.mkIf (cfg.enable && cfg.lean4) {
    # Integration with the Lean 4 theorem prover
    plugins.lean = {
      enable = true;

      # Unicode expansion is handled by nvim-cmp with latex-symbols, but
      # lean.nvim's abbreviations work indepently, and automatically insert
      # themselves when you press space to move on, rather than needing to be
      # manually selected from the pop-up menu
      abbreviations.enable = true;

      # Use the version of lean from the surrounding environment
      leanPackage = null;
    };
  };
}
