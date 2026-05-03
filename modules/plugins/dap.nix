{
  flake.nixvimModules.dap = {
    # Debug Adapter Protocol
    plugins = {
      dap = {
        enable = true;

        lazyLoad.settings.keys = [
          "<leader>db"
          "<leader>dc"
          "<leader>dso"
          "<leader>dsi"
          "<leader>dr"
        ];

        luaConfig.post = ''
          require('lz.n').trigger_load('nvim-dap-virtual-text')
        '';
      };

      dap-virtual-text = {
        enable = true;
        lazyLoad.settings.lazy = true; # Trigger manually from dap
      };

      dap-ui = {
        enable = true;

        lazyLoad.settings = {
          before.__raw = ''
            function()
              require('lz.n').trigger_load('nvim-dap')
            end
          '';

          keys = [ "<leader>dui" ];
        };
      };

      lz-n.keymaps = [
        {
          plugin = "nvim-dap";
          key = "<leader>db";
          action.__raw = "function() require('dap').toggle_breakpoint() end";
          mode = "n";
          options = {
            silent = true;
            desc = "Toggle DAP breakpoint";
          };
        }
        {
          plugin = "nvim-dap";
          key = "<leader>dc";
          action.__raw = "function() require('dap').continue() end";
          mode = "n";
          options = {
            silent = true;
            desc = "DAP continue";
          };
        }
        {
          plugin = "nvim-dap";
          key = "<leader>dso";
          action.__raw = "function() require('dap').step_over() end";
          mode = "n";
          options = {
            silent = true;
            desc = "DAP step over";
          };
        }
        {
          plugin = "nvim-dap";
          key = "<leader>dsi";
          action.__raw = "function() require('dap').step_into() end";
          mode = "n";
          options = {
            silent = true;
            desc = "DAP step into";
          };
        }
        {
          plugin = "nvim-dap";
          key = "<leader>dr";
          action.__raw = "function() require('dap').repl.open() end";
          mode = "n";
          options = {
            silent = true;
            desc = "Open DAP REPL";
          };
        }

        {
          plugin = "nvim-dap-ui";
          key = "<leader>dui";
          action.__raw = "function() require('dapui').toggle() end";
          mode = "n";
          options = {
            silent = true;
            desc = "Open DAP UI";
          };
        }
      ];
    };
  };
}
