{pkgs, ...}: {
  extraPlugins = [
    pkgs.vimPlugins.windows-nvim
    (pkgs.vimUtils.buildVimPlugin
      {
        name = "animation.nvim";
        src = pkgs.fetchFromGitHub {
          owner = "anuvyklack";
          repo = "animation.nvim";
          rev = "fb77091ab72ec9971aee0562e7081182527aaa6a";
          hash = "sha256-KyFzPI2B0ioIABnhC6MwaHYLcuUzSqCsmcGpMei4XXk=";
        };
      })
    (pkgs.vimUtils.buildVimPlugin
      {
        name = "middleclass";
        src = pkgs.fetchFromGitHub {
          owner = "anuvyklack";
          repo = "middleclass";
          rev = "9fab4d5bca67262614960960ca35c4740eb2be2c";
          hash = "sha256-scJX7ovVZ6YBRp2lTP7JswyZ0smvVZneGRGBvwFsyOQ=";
        };
      })
  ];

  extraConfigLua = ''
    require("windows").setup({})
  '';

  opts = {
    winwidth = 15;
    winminwidth = 0;
    equalalways = false;
  };

  keymaps = [
    {
      key = "<C-w><C-w>";
      action = "<cmd>WindowsMaximize<cr>";
      mode = "n";
      options = {
        silent = true;
        desc = "Toggle maximise the current window";
      };
    }
  ];
}
