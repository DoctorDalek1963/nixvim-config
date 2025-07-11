{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.setup.pluginGroups;
in {
  config = lib.mkIf cfg.base {
    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "comfy-line-numbers.nvim";
        src = pkgs.fetchFromGitHub {
          owner = "mluders";
          repo = "comfy-line-numbers.nvim";
          rev = "eb1c966e22fbabe3a3214c78bda9793ccf9d2a5d";
          hash = "sha256-KaHhmm7RhJEtWedKE7ab+Aioe3jJLP0TUlnokszU5DY=";
        };
      })
    ];

    extraConfigLua = let
      maxDigit = 4;
      labelCount = 80;

      mod' = n: let
        m = lib.mod n maxDigit;
      in
        if m == 0
        then maxDigit
        else m;

      # It's actually a mixed base system because all non-unit columns can be
      # zero but the unit column can't. That makes everything weird and freaky,
      # so we have to define our own toBase function
      toBase = n:
        if n < 0
        then abort "comfy-line-numbers toBase should never be called with a negative number"
        else if n == 0
        then []
        else (toBase ((n - 1) / maxDigit)) ++ [(mod' n)];

      labelNums = map toBase (lib.range 1 labelCount);
      labels = map (xs: lib.concatMapStringsSep "" toString xs) labelNums;
    in
      # lua
      ''
        require('comfy-line-numbers').setup({
          labels = { ${lib.concatMapStringsSep ", " (x: "'${x}'") labels} },
          up_key = 'k',
          down_key = 'j'
        })
      '';

    opts.relativenumber = lib.mkForce false;

    # Taken from https://github.com/sitiom/nvim-numbertoggle/blob/main/plugin/numbertoggle.lua
    # and adapted to use comfy-line-numbers. This doesn't work when moving between
    # buffers because comfy-line-numbers applies to all buffers at the  same time,
    # so we only care about moving between normal, insert, and command mode
    autoGroups.numbertoggle_augroup = {clear = true;};
    autoCmd = [
      {
        desc = "Enable comfy line numbers in normal mode";
        group = "numbertoggle_augroup";
        pattern = "*";
        event = ["BufEnter" "InsertLeave" "CmdlineLeave"];
        callback.__raw = ''
          function()
            if vim.o.number and vim.api.nvim_get_mode().mode ~= "i" then
              require("comfy-line-numbers").enable_line_numbers()
            end
           end
        '';
      }
      {
        desc = "Disable comfy line numbers outside of normal mode";
        group = "numbertoggle_augroup";
        pattern = "*";
        event = ["InsertEnter" "CmdlineEnter"];
        callback.__raw = ''
          function()
            if vim.o.number then
              require("comfy-line-numbers").disable_line_numbers()

              -- Conditional taken from https://github.com/rockyzhang24/dotfiles/commit/03dd14b5d43f812661b88c4660c03d714132abcf
              -- Workaround for https://github.com/neovim/neovim/issues/32068
              if not vim.tbl_contains({"@", "-"}, vim.v.event.cmdtype) then
                vim.cmd "redraw"
              end
            end
           end
        '';
      }
    ];
  };
}
