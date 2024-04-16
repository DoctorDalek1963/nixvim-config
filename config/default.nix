{pkgs, ...}: {
  imports = [
    ./autoCmdGroups.nix
    ./globals.nix
    ./keymaps.nix
    ./options.nix
    ./plugins/default.nix
  ];

  enableMan = false;

  extraPackages = with pkgs; [
    alejandra # For nixd lsp
    delta # For actions-preview.nvim
    vscode-extensions.vadimcn.vscode-lldb # For Rustaceanvim debugging
  ];

  colorschemes.catppuccin = {
    enable = true;
    settings = {
      flavour = "macchiato";
      background = {
        light = "latte";
        dark = "macchiato";
      };
      dimInactive = {
        enabled = true;
        percentage = 0.15;
      };
      integrations = {
        cmp = true;
        gitgutter = true;
        rainbow_delimiters = true;
        treesitter = true;
        treesitter_context = true;
        dap = {
          enabled = true;
          enable_ui = true;
        };
        indent_blankline = {
          enabled = true;
          colored_indent_levels = true;
        };
        native_lsp = true;
        telescope = true;
      };
    };
  };

  userCommands = {
    Rmsp = {
      desc = "Remove all trailing spaces";
      command = "execute '%s/\\s\\+$//e'";
    };
  };

  extraConfigVim =
    # vim
    ''
      function! VisualWordsAndChars()
          if mode() == "v"
              return wordcount().visual_words . "W " . wordcount().visual_chars . "C"
          else
              return ""
          endif
      endfunction

      function! UpdateGitPS1Status()
          let s:git_directory = substitute(resolve(expand("%:p")), '\/[^/]\+$', "", "")

          if s:git_directory == "" |
              let g:git_ps1_status = "" |
          else |
              let g:git_ps1_status = system("(cd '" . s:git_directory . "'; GIT_PS1_SHOWDIRTYSTATE=true; GIT_PS1_SHOWSTASHSTATE=true; GIT_PS1_SHOWUNTRACKEDFILES=true; GIT_PS1_SHOWUPSTREAM='auto'; GIT_PS1_HIDE_IF_PWD_IGNORED=true; source ~/.git-prompt.sh; __git_ps1 '[%s]')") |
          endif
      endfunction

      function! GitPS1Status()
          return g:git_ps1_status
      endfunction
    '';

  extraConfigLua =
    # lua
    ''
      -- Add borders to floating windows
      do
        local _border = "rounded"

        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
          vim.lsp.handlers.hover, {
            border = _border
          }
        )

        vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
          vim.lsp.handlers.signature_help, {
            border = _border
          }
        )

        vim.diagnostic.config{
          float = {border = _border}
        }
      end
    '';
}
