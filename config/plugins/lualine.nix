let
  custom-filename = {
    name = "filename";
    extraConfig = {
      file_status = true; # Readonly, modified
      newfile_status = true; # Before first write
      path = 1; # Relative path
      symbols = {
        modified = "[+]";
        readonly = "[RO]";
        unnamed = "[No Name]";
        newfile = "[New]";
      };
    };
    fmt =
      # lua
      ''
        function(text)
          if vim.fn.winwidth(0) <= 75 then
            local final_path_components = {}

            for path_component, slash in string.gmatch(text, "([^/]+)(/?)") do
              if slash == "" then
                -- This is the filename, so we don't want to shorten it
                table.insert(final_path_components, path_component)
              else
                table.insert(final_path_components, string.sub(path_component, 0, 1))
              end
            end

            return table.concat(final_path_components, "/")
          else
            return text
          end
        end
      '';
  };
in {
  plugins.lualine = {
    enable = true;

    sections = {
      lualine_a = [
        {
          name = "mode";
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
        "branch"
        "diff"
        {
          name = "diagnostics";
          extraConfig.sources = ["nvim_lsp" "nvim_diagnostic"];
        }
      ];
      lualine_c = [
        custom-filename
      ];
      lualine_x = [
        {
          name = "encoding";
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
          name = "fileformat";
          extraConfig.symbols = {
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
          name = "progress";
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

    inactiveSections = {
      lualine_a = [];
      lualine_b = [
        "diff"
        {
          name = "diagnostics";
          extraConfig.sources = ["nvim_lsp" "nvim_diagnostic"];
        }
      ];
      lualine_c = [custom-filename];
      lualine_x = ["location"];
      lualine_y = [];
      lualine_z = [];
    };
  };
}
