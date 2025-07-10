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
      maxCount = 80;

      labelNums = map (i: map (x: x + 1) (lib.toBaseDigits maxDigit i)) (lib.range 0 (maxCount - 1));
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
