{
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.setup.tools.dapDebugger {
    plugins.dap = {
      enable = true;
      extensions = {
        dap-ui.enable = true;
        dap-virtual-text.enable = true;
      };
    };

    keymaps = [
      # Toggle DAP breakpoint
      {
        key = "<leader>db";
        action.__raw = "require('dap').toggle_breakpoint";
        mode = "n";
        options.silent = true;
      }
      # DAP continue
      {
        key = "<leader>dc";
        action.__raw = "require('dap').continue";
        mode = "n";
        options.silent = true;
      }
      # DAP step over
      {
        key = "<leader>dso";
        action.__raw = "require('dap').step_over";
        mode = "n";
        options.silent = true;
      }
      # DAP step into
      {
        key = "<leader>dsi";
        action.__raw = "require('dap').step_into";
        mode = "n";
        options.silent = true;
      }
      # Open DAP REPL
      {
        key = "<leader>dr";
        action.__raw = "require('dap').repl.open";
        mode = "n";
        options.silent = true;
      }
      # Open DAP UI
      {
        key = "<leader>dui";
        action.__raw =
          # lua
          ''
            function()
              require('dapui').setup()
              require('dapui').toggle()
            end
          '';
        mode = "n";
        options.silent = true;
      }
    ];
  };
}
