{
  lib,
  config,
  ...
}:
let
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
in
{
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
            "diff"
            {
              __unkeyed-1 = "diagnostics";
              sources = [
                "nvim_lsp"
                "nvim_diagnostic"
              ];
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
          lualine_z = [ "location" ];
        };

        inactive_sections = {
          lualine_a = [ ];
          lualine_b = [
            "diff"
            {
              __unkeyed-1 = "diagnostics";
              sources = [
                "nvim_lsp"
                "nvim_diagnostic"
              ];
            }
          ];
          lualine_c = [ custom-filename ];
          lualine_x = [ "location" ];
          lualine_y = [ ];
          lualine_z = [ ];
        };
      };
    };
  };
}
