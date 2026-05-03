{
  flake.nixvimModules.java =
    { lib, config, ... }:
    {
      plugins.jdtls = {
        enable = true;
        settings.cmd = [
          (lib.getExe config.plugins.jdtls.jdtLanguageServerPackage)
          "-configuration"
          (lib.nixvim.mkRaw ''vim.env.HOME .. "/.cache/jdtls"'')
          "-data"
          (lib.nixvim.mkRaw ''require("jdtls.setup").find_root({".git", "mvnw", "gradlew"}) .. "/.jdtls"'')
        ];
      };
    };
}
