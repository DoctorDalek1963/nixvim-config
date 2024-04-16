# The whole system here comes from this GitHub discussion: https://github.com/nix-community/nixvim/discussions/540#discussioncomment-6881292
{
  pkgs,
  config,
  ...
}: let
  tree-sitter-just = pkgs.tree-sitter.buildGrammar {
    language = "just";
    version = "0.0.0+43f2c5e";
    src = pkgs.fetchFromGitHub {
      owner = "IndianBoy42";
      repo = "tree-sitter-just";
      rev = "43f2c5efb96e51bbd8e64284662911b60849df00";
      hash = "sha256-lFxbpO2Oj++/23PqQOE4THjHaztdCLvl2sOw7aff8U0=";
    };
  };

  makeExtraFiles = pkg: lang: files:
    builtins.listToAttrs (map (x: {
        name = "queries/${lang}/${x}.scm";
        value = builtins.readFile "${pkg}/queries/${lang}/${x}.scm";
      })
      files);
in {
  plugins.treesitter = {
    enable = true;
    indent = true;

    languageRegister = {
      just = "just";
    };

    grammarPackages = config.plugins.treesitter.package.passthru.allGrammars ++ [tree-sitter-just];
  };

  extraFiles =
    makeExtraFiles
    tree-sitter-just
    "just"
    ["folds" "highlights" "indents" "injections" "locals" "textobjects"];

  extraConfigLua =
    # lua
    ''
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

      parser_config.just = { filetype = "just" }
    '';
}
