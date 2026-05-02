let
  autoCmdGroups = [
    {
      group = "tabs";
      commands = [
        {
          desc = "Expand tabs to spaces";
          event = "FileType";
          pattern = [
            "haskell"
            "nix"
            "python"
            "rst"
            "just"
            "bib"
            "tex"
          ];
          command = "setlocal expandtab";
        }
        {
          desc = "Set a tab to be 2 spaces";
          event = "FileType";
          pattern = [
            "haskell"
            "nix"
          ];
          command = "setlocal shiftwidth=2 tabstop=2";
        }
        {
          desc = "Set a tab to be 3 spaces";
          event = "FileType";
          pattern = "rst";
          command = "setlocal shiftwidth=3 tabstop=3";
        }
      ];
    }
    {
      group = "plaintext";
      commands = [
        {
          desc = "Enable spell check and word wrapping in plain text files";
          event = "FileType";
          pattern = [
            "markdown"
            "rst"
            "tex"
            "text"
          ];
          command = "setlocal spell linebreak";
        }
      ];
    }
    {
      group = "markdown";
      commands = [
        {
          desc = "Set the textwidth and formatoptions for markdown files";
          event = "FileType";
          pattern = "markdown";
          command = "setlocal textwidth=0 formatoptions=q";
        }
      ];
    }
  ];
in
{
  flake.nixvimModules.autocmd-groups = {
    autoCmd = builtins.concatMap (
      def: map (command: command // { group = "${def.group}_augroup"; }) def.commands
    ) autoCmdGroups;

    autoGroups = builtins.foldl' (acc: elem: acc // elem) { } (
      map (def: {
        "${def.group}_augroup" = {
          clear = true;
        };
      }) autoCmdGroups
    );
  };
}
