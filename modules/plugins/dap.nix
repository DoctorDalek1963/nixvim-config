{
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.setup.pluginGroups.programming {
    plugins = {
      cmp-dap.enable = true;
      cmp.settings.sources = [{name = "dap";}];

      dap.enable = true;
      dap-ui.enable = true;
      dap-virtual-text.enable = true;
    };

    keymaps = [
      {
        key = "<leader>db";
        action.__raw = "require('dap').toggle_breakpoint";
        mode = "n";
        options = {
          silent = true;
          desc = "Toggle DAP breakpoint";
        };
      }
      {
        key = "<leader>dc";
        action.__raw = "require('dap').continue";
        mode = "n";
        options = {
          silent = true;
          desc = "DAP continue";
        };
      }
      {
        key = "<leader>dso";
        action.__raw = "require('dap').step_over";
        mode = "n";
        options = {
          silent = true;
          desc = "DAP step over";
        };
      }
      {
        key = "<leader>dsi";
        action.__raw = "require('dap').step_into";
        mode = "n";
        options = {
          silent = true;
          desc = "DAP step into";
        };
      }
      {
        key = "<leader>dr";
        action.__raw = "require('dap').repl.open";
        mode = "n";
        options = {
          silent = true;
          desc = "Open DAP REPL";
        };
      }
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
        options = {
          silent = true;
          desc = "Open DAP UI";
        };
      }
    ];
  };
}
