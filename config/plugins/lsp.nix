{pkgs, ...}: {
  plugins = {
    # Rust tools: LSP, formatter, debugger
    # TODO: How does this integrate with my system rustup? What about toolchains?
    rustaceanvim = {
      enable = true;
      tools.hoverActions.replaceBuiltinHover = false;
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

    # Autoformatting for all servers that support it
    lsp-format = {
      enable = true;
      lspServersToEnable = "all";
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
        bashls.enable = true;

        # C/C++
        ccls.enable = true;

        # CSS
        cssls.enable = true;

        # Dockerfile
        dockerls.enable = true;

        # Haskell
        hls.enable = true;

        # HTML
        html.enable = true;

        # Java
        java-language-server.enable = true;

        # JSON
        jsonls.enable = true;

        # Julia
        julials.enable = true;

        # Kotlin
        kotlin-language-server.enable = true;

        # LaTeX
        # TODO: Make sure the LaTeX referrence manual is installed as an info node:
        # https://github.com/astoff/digestif/wiki/Common-installation-issues#info-nodes
        digestif.enable = true;

        # Lua
        lua-ls.enable = true;

        # Nix
        nixd = {
          enable = true;
          settings.formatting.command = "${pkgs.alejandra}/bin/alejandra --quiet";
        };

        # Python
        ruff-lsp.enable = true; # Currently broken for some reason

        # TOML
        taplo.enable = true;

        # YAML
        yamlls.enable = true;

        # XML
        lemminx.enable = true;
      };
    };
  };
}
