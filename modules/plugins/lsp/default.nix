{
  lib,
  config,
  ...
}: {
  imports = [
    ./nix.nix

    ./rust.nix
  ];

  config = lib.mkIf config.setup.lsp.enable {
    # Highlight diagnostic locations only on the current line
    diagnostics.virtual_lines.only_current_line = true;

    opts = {
      # Backups can mess with LSPs
      backup = false;
      writebackup = false;
    };

    plugins = {
      # Autoformatting for all servers that support it
      lsp-format = {
        enable = true;
        lspServersToEnable = "all";
      };

      # Highlight exact diagnostic locations on the line
      lsp-lines.enable = true;

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
      };
    };
  };
}
