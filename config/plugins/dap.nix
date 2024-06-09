{
  pkgs,
  lib,
  dapDebugger,
  elixirLsp,
  ...
}: let
  elixirConfig = {
    adapters.executables.mix_task = {
      command = "${pkgs.elixir-ls}/lib/debug_adapter.sh";
      args = [];
    };
    configurations.elixir = [
      {
        name = "mix test";
        request = "launch";
        type = "mix_task";
        task = "test";

        taskArgs = ["--trace"];
        requireFiles = [
          "test/**/test_helper.exs"
          "test/**/*_test.exs"
        ];

        startApps = true; # For Phoenix projects
        projectDir = "\${workspaceFolder}";
      }
      {
        name = "mix test (specific test)";
        request = "launch";
        type = "mix_task";
        task = "test";

        taskArgs.__raw =
          # lua
          ''
            function()
              local filename = vim.fn.input({
                prompt = 'File containing desired test: ',
                default = vim.fn.getcwd() .. '/',
                completion = 'file'
              })
              if filename == "" then
                return dap.ABORT
              end

              local linenumber = vim.fn.input({prompt = 'Line number of desired test: '})
              if tonumber(linenumber) == nil then
                return dap.ABORT
              end

              return {
                '--trace',
                filename .. ':' .. linenumber
              }
            end
          '';
        requireFiles = ["test/**/test_helper.exs"];

        startApps = true; # For Phoenix projects
        projectDir = "\${workspaceFolder}";
      }
      {
        name = "Phoenix server";
        request = "launch";
        type = "mix_task";
        task = "phx.server";

        projectDir = "\${workspaceRoot}";
      }
    ];
  };

  optSet = cond: set:
    if cond
    then set
    else {};
in {
  config = lib.mkIf dapDebugger {
    plugins.dap =
      {
        enable = true;
        extensions = {
          dap-ui.enable = true;
          dap-virtual-text.enable = true;
        };
      }
      // optSet elixirLsp elixirConfig;
  };
}
