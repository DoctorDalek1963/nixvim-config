{
  flake.nixvimModules.pencil =
    { pkgs, ... }:
    {
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
