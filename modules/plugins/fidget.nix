{
  flake.nixvimModules.fidget = {
    # Show update messages in the bottom right
    plugins.fidget = {
      enable = true;
      settings.notification = {
        filter = "info";
        override_vim_notify = true;

        # Transparency
        window.winblend = 0;
      };
    };
  };
}
