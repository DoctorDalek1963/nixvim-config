{
  plugins.yazi = {
    enable = true;
    settings.open_for_directories = true;
  };

  keymaps = [
    {
      key = "<leader>y";
      action.__raw = "require('yazi').yazi";
      mode = "n";
      options.desc = "Open yazi";
    }
  ];
}
