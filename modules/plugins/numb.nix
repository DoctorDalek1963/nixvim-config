{pkgs, ...}: {
  extraPlugins = [pkgs.vimPlugins.numb-nvim];
  extraConfigLua = ''
    require('numb').setup()
  '';
}
