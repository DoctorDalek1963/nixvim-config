{
  pkgs,
  lib,
  config,
  ...
}: let
  git-prompt-repo = pkgs.fetchFromGitHub {
    owner = "git";
    repo = "git";
    rev = "v2.46.0";
    hash = "sha256-Jxsxkh+V9h0NQpFxlPJ5SALESm4p1URRby9b8VaO+5k=";
    sparseCheckout = ["contrib/completion/git-prompt.sh"];
  };

  custom-filename = {
    __unkeyed-1 = "filename";

    file_status = true; # Readonly, modified
    newfile_status = true; # Before first write
    path = 1; # Relative path
    symbols = {
      modified = "[+]";
      readonly = "[RO]";
      unnamed = "[No Name]";
      newfile = "[New]";
    };

    fmt =
      # lua
      ''
        function(text)
          -- We need 32 characters in the hash but lua doesn't support "[%a%d]{32}" syntax
          local hash_eight_chars = "[%a%d][%a%d][%a%d][%a%d][%a%d][%a%d][%a%d][%a%d]"
          local hash_pattern = hash_eight_chars .. hash_eight_chars .. hash_eight_chars .. hash_eight_chars

          text = string.gsub(text, "/nix/store/" .. hash_pattern .. "%-([^/]+)", "/n/s/<hash>-%1")

          if vim.fn.winwidth(0) <= 75 then
            local leading_slash = string.sub(text, 0, 1) == "/"
            local final_path_components = {}

            for path_component, slash in string.gmatch(text, "([^/]+)(/?)") do
              if slash == "" then
                -- This is the filename or "<hash>-" part of a nix store path, so we don't want to shorten it
                table.insert(final_path_components, path_component)
              else
                table.insert(final_path_components, string.sub(path_component, 0, 1))
              end
            end

            local final_path = table.concat(final_path_components, "/")

            if leading_slash then
              return "/" .. final_path
            else
              return final_path
            end
          else
            return text
          end
        end
      '';
  };
in {
  config = lib.mkIf config.setup.pluginGroups.base {
    plugins.lualine = {
      enable = true;

      settings = {
        sections = {
          lualine_a = [
            {
              __unkeyed-1 = "mode";
              fmt =
                # lua
                ''
                  function(text)
                    if vim.fn.winwidth(0) <= 90 then
                      return string.sub(text, 0, 1) -- Only first letter
                    else
                      return text
                    end
                  end
                '';
            }
          ];
          lualine_b = [
            {
              __unkeyed-1.__raw = "function() return GIT_PS1_STATUS end";
              # icon = "";
            }
            "diff"
            {
              __unkeyed-1 = "diagnostics";
              sources = ["nvim_lsp" "nvim_diagnostic"];
            }
          ];
          lualine_c = [
            custom-filename
          ];
          lualine_x = [
            {
              __unkeyed-1 = "encoding";
              fmt =
                # lua
                ''
                  function(text)
                    if vim.fn.winwidth(0) <= 90 then
                      return ""
                    else
                      return text
                    end
                  end
                '';
            }
            {
              __unkeyed-1 = "fileformat";
              symbols = {
                unix = ""; # LF is default, so we only care if it's something else
                dos = "CRLF";
                mac = "CR";
              };
              fmt =
                # lua
                ''
                  function(text)
                    if vim.fn.winwidth(0) <= 90 then
                      return ""
                    else
                      return text
                    end
                  end
                '';
            }
            "filetype"
          ];
          lualine_y = [
            {
              __unkeyed-1 = "progress";
              fmt =
                # lua
                ''
                  function(text)
                    if text == "Top" then
                      return "0%%"
                    elseif text == "Bot" then
                      return "100%%"
                    else
                      return text
                    end
                  end
                '';
            }
          ];
          lualine_z = ["location"];
        };

        inactive_sections = {
          lualine_a = [];
          lualine_b = [
            "diff"
            {
              __unkeyed-1 = "diagnostics";
              sources = ["nvim_lsp" "nvim_diagnostic"];
            }
          ];
          lualine_c = [custom-filename];
          lualine_x = ["location"];
          lualine_y = [];
          lualine_z = [];
        };
      };
    };

    extraConfigLuaPre = ''GIT_PS1_STATUS = "git PS1 status uninitialised"'';

    autoGroups = {
      update_git_ps1_status_augroup = {
        clear = true;
      };
    };

    autoCmd = [
      {
        desc = "Update the GIT_PS1_STATUS global variable";
        event = ["BufEnter" "BufWritePost"];
        pattern = "*";
        callback.__raw =
          # lua
          ''
            function(_tbl)
              local resolved_filename = vim.api.nvim_exec2('echo resolve(expand("%:p"))', { output = true }).output
              local directory = string.gsub(resolved_filename, "/[^/]+$", "")

              if directory == "" then
                GIT_PS1_STATUS = ""
                return
              end

              local stdout = vim.system(
                {
                  "${pkgs.bash}/bin/bash",
                  "-c",
                  "source ${git-prompt-repo}/contrib/completion/git-prompt.sh; __git_ps1 '[%s]'"
                },
                {
                  cwd = directory,
                  env = {
                    GIT_PS1_SHOWDIRTYSTATE = "true",
                    GIT_PS1_SHOWSTASHSTATE = "true",
                    GIT_PS1_SHOWUNTRACKEDFILES = "true",
                    GIT_PS1_SHOWUPSTREAM = "auto",
                    GIT_PS1_HIDE_IF_PWD_IGNORED = "true"
                  }
                }
              ):wait().stdout

              -- Lua treats % weird
              GIT_PS1_STATUS = string.gsub(stdout, "%%", "%%%%")
            end
          '';
        group = "update_git_ps1_status_augroup";
      }
    ];
  };
}
