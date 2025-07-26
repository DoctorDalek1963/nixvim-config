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
        # Linting
        pycodestyle = {
          enabled = true;
          maxLineLength = 120;
        };
        pyflakes.enabled = true;
        flake8.enabled = false; # Conflicts with pycodestyle/pyflakes combo

        # FIXME: Currently causes the build to fail
        # pylsp_mypy.enabled = true;

        # Formatting
        black.enabled = true;
        isort.enabled = true;
        yapf.enabled = false;

        # Completion
        jedi_completion = {
          enabled = true;
          fuzzy = true;
        };
        jedi_definition.enabled = true;

        # Rope conflicts with Jedi and creates .ropeproject/ in repos
        pylsp_rope.enabled = false;
        rope_autoimport.enabled = false;
        rope_completion.enabled = false;
      };
    };
  };
}
