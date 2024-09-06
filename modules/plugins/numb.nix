{
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.setup.pluginGroups.niceToHave {
    extraPlugins = [pkgs.vimPlugins.numb-nvim];
    extraConfigLua = ''
      require('numb').setup()
    '';
  };
}
