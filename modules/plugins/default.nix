{ self, ... }:
{
  flake.nixvimModules = {
    plugin-group-base = {
      imports = with self.nixvimModules; [
        lualine
      ];
    };

    plugin-group-comfortable = {
      imports = with self.nixvimModules; [
        plugin-group-base
        auto-dark-mode
      ];
    };

    plugin-group-programming = {
      imports = with self.nixvimModules; [
        plugin-group-comfortable
      ];
    };
  };
}
