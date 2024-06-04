{
  pkgs,
  cLsps,
  configFileLsps,
  dockerfileLsp,
  elixirLsp,
  haskellLsp,
  juliaLsp,
  jvmLsps,
  latexLsp,
  luaLsp,
  pythonLsp,
  rustLsp,
  shellLsps,
  webLsps,
  ...
}: {
  plugins = {
    # Rust tools: LSP, formatter, debugger
    rustaceanvim = {
      enable = rustLsp;
      rustAnalyzerPackage = null; # Use rust-analyzer from environment, typically via `nix develop`
      settings = {
        tools.hover_actions.replace_builtin_hover = false;
        server.on_attach = "__lspOnAttach";

        # This config was adapted from https://github.com/mrcjkb/rustaceanvim#using-codelldb-for-debugging
        dap.adapter =
          # lua
          ''
            function()
              local extension_path = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb"
              local codelldb_path = extension_path .. "/adapter/codelldb"
              local liblldb_path = extension_path .. "/lldb/lib/liblldb.so"

              return require("rustaceanvim.config").get_codelldb_adapter(codelldb_path, liblldb_path)
            end
          '';
      };
    };

    # Autoformatting for all servers that support it
    lsp-format = {
      enable = true;
      lspServersToEnable = "all";
    };

    # Highlight exact diagnostic locations on the line
    lsp-lines = {
      enable = true;
      currentLine = true;
    };

    # See https://nix-community.github.io/nixvim/plugins/lsp/index.html for options and supported servers
    lsp = {
      enable = true;

      keymaps = {
        silent = true;
        lspBuf = {
          "gd" = "definition";
          "<leader>f" = "format";
          "K" = "hover";
          "gi" = "implementation";
          "gr" = "references";
          "<leader>rn" = "rename";
          "gy" = "type_definition";
        };
        diagnostic = {
          "<leader>j" = "goto_next";
          "<leader>k" = "goto_prev";
        };
      };

      servers = {
        # Bash
        bashls.enable = shellLsps;

        # C/C++
        ccls.enable = cLsps;

        # CSS
        cssls.enable = webLsps;

        # Dockerfile
        dockerls.enable = dockerfileLsp;

        # Elixir
        elixirls.enable = elixirLsp;

        # Haskell
        hls.enable = haskellLsp;

        # HTML
        html.enable = webLsps;

        # Java
        java-language-server.enable = jvmLsps;

        # JSON
        jsonls.enable = configFileLsps || webLsps;

        # Julia
        julials.enable = juliaLsp;

        # Kotlin
        kotlin-language-server.enable = jvmLsps;

        # LaTeX
        # TODO: Make sure the LaTeX referrence manual is installed as an info node:
        # https://github.com/astoff/digestif/wiki/Common-installation-issues#info-nodes
        digestif.enable = latexLsp;

        # Lua
        lua-ls.enable = luaLsp;

        # Nix
        nixd = {
          # This is always enabled even in nvim-small because I'm always
          # editing Nix files
          enable = true;
          settings.formatting.command = ["${pkgs.alejandra}/bin/alejandra" "--quiet"];
        };

        # Python
        ruff-lsp.enable = pythonLsp; # Currently broken for some reason

        # TOML
        taplo.enable = configFileLsps;

        # TypeScript
        tsserver.enable = webLsps;

        # YAML
        yamlls.enable = configFileLsps;

        # XML
        lemminx.enable = configFileLsps;
      };
    };
  };
}
