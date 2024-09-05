{
  lib,
  config,
  ...
}: let
  autoCmdGroups = [
    {
      group = "tabs";
      commands = [
        {
          desc = "Expand tabs to spaces";
          event = "FileType";
          pattern = ["haskell" "nix" "python" "rst"];
          command = "setlocal expandtab";
        }
        {
          desc = "Set a tab to be 2 spaces";
          event = "FileType";
          pattern = ["haskell" "nix"];
          command = "setlocal shiftwidth=2 tabstop=2";
        }
        {
          desc = "Set a tab to be 2 spaces";
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
          pattern = ["markdown" "rst" "tex" "text"];
          command = "setlocal spell linebreak";
        }
      ];
    }
    {
      group = "markdown";
      commands =
        [
          {
            desc = "Set the textwidth and formatoptions for markdown files";
            event = "FileType";
            pattern = "markdown";
            command = "setlocal textwidth=0 formatoptions=q";
          }
        ]
        ++ (lib.optional config.plugins.markdown-preview.enable
          {
            desc = "Enable SoftPencil";
            event = "FileType";
            pattern = "markdown";
            command = "SoftPencil";
          });
    }
    {
      group = "python";
      commands = [
        {
          desc = "Set colour column at 120 lines";
          event = "FileType";
          pattern = "python";
          command = "setlocal colorcolumn=120";
        }
      ];
    }
  ];
in {
  autoCmd =
    builtins.concatMap
    (def: builtins.map (command: command // {group = "${def.group}_augroup";}) def.commands)
    autoCmdGroups;

  autoGroups =
    builtins.foldl'
    (acc: elem: acc // elem)
    {}
    (builtins.map (def: {"${def.group}_augroup" = {clear = true;};}) autoCmdGroups);
}
