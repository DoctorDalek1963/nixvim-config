{
  pkgs,
  lib,
  config,
  ...
}:
{
  config = lib.mkIf config.setup.pluginGroups.base {
    extraPlugins = [ pkgs.vimPlugins.vim-pencil ];

    autoCmd = [
      {
        desc = "Enable SoftPencil";
        event = "FileType";
        pattern = [
          "markdown"
          "rst"
          "tex"
          "text"
        ];
        command = "SoftPencil";
        group = "plaintext_augroup";
      }
    ];
  };
}
