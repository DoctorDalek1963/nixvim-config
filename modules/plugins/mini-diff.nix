{
  flake.nixvimModules.mini-diff = {
    # Show diff signs in the left column and allow staging hunks with gh
    plugins.mini = {
      enable = true;

      modules.diff = {
        delay.text_change = 0;

        view = {
          style = "sign";

          signs = {
            add = "+";
            change = "~";
            delete = "-";
          };
        };
      };
    };

    # Always draw the sign column
    opts.signcolumn = "yes";
  };
}
