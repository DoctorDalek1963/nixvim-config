{
  lib,
  config,
  ...
}:
let
  cfg = config.setup.lang;
in
{
  config = lib.mkIf (cfg.enable && cfg.python) {
    plugins.lsp.servers.pylsp = {
      enable = true;
      settings.plugins = {
        autopep8.enabled = true;
        flake8.enabled = true;
        pycodestyle.enabled = true;
        pydocstyle.enabled = true;
        pylsp_mypy.enabled = true;
        rope.enabled = true;
        ruff.enabled = true;
      };
    };
  };
}
