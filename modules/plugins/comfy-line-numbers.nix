{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.setup.pluginGroups;
in {
  config = lib.mkIf cfg.base {
    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "comfy-line-numbers.nvim";
        src = pkgs.fetchFromGitHub {
          owner = "mluders";
          repo = "comfy-line-numbers.nvim";
          rev = "eb1c966e22fbabe3a3214c78bda9793ccf9d2a5d";
          hash = "sha256-KaHhmm7RhJEtWedKE7ab+Aioe3jJLP0TUlnokszU5DY=";
        };
      })
    ];

    extraConfigLua = let
      maxDigit = 4;
      labelCount = 80;

      mod' = n: let
        m = lib.mod n maxDigit;
      in
        if m == 0
        then maxDigit
        else m;

      # It's actually a mixed base system because all non-unit columns can be
      # zero but the unit column can't. That makes everything weird and freaky,
      # so we have to define our own toBase function
      toBase = n:
        if n < 0
        then abort "comfy-line-numbers toBase should never be called with a negative number"
        else if n == 0
        then []
        else (toBase ((n - 1) / maxDigit)) ++ [(mod' n)];

      labelNums = map toBase (lib.range 1 labelCount);
      labels = map (xs: lib.concatMapStringsSep "" toString xs) labelNums;
    in
      # lua
      ''
        require('comfy-line-numbers').setup({
          labels = { ${lib.concatMapStringsSep ", " (x: "'${x}'") labels} },
          up_key = 'k',
          down_key = 'j'
        })
      '';
  };
}
