{ self, ... }:
{
  flake.nixvimModules = {
    plugin-group-base = {
      imports = with self.nixvimModules; [
        core
        lualine
        transparent
      ];
    };

    plugin-group-comfortable = {
      imports = with self.nixvimModules; [
        plugin-group-base
        auto-dark-mode
        windows
      ];
    };

    plugin-group-programming = {
      imports = with self.nixvimModules; [
        plugin-group-comfortable
        undotree
      ];
    };
  };
}
