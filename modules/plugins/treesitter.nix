{
  plugins = {
    # Highlight inline strings with other languages in Nix files
    hmts.enable = true;

    treesitter = {
      enable = true;
      settings.indent.enable = true;
    };

    # Add scope context with treesitter
    treesitter-context.enable = true;

    # Automatically close and rename HTML-like tags in pairs with Treesitter
    ts-autotag.enable = true;

    # Use the correct comment syntax for embedded languages
    ts-context-commentstring.enable = true;

    # Integrations with other plugins
    vim-matchup.treesitterIntegration.enable = true;
  };
}
