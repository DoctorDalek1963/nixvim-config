{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.setup.lang;

  buildDcd =
    configType:
    pkgs.buildDubPackage rec {
      pname = "dcd-${configType}";
      version = "0.15.2";

      src = pkgs.fetchFromGitHub {
        owner = "dlang-community";
        repo = "DCD";
        rev = "v${version}";
        hash = "sha256-dJ4Ql3P9kPQhQ3ZrNcTAEB5JHSslYn2BN8uqq6vGetY=";
      };

      dubLock = ./dcd-dub-lock.json;

      dubBuildFlags = [ "--config=${configType}" ];

      doCheck = true;

      installPhase = ''
        runHook preInstall
        install -Dm755 bin/* -t $out/bin
        runHook postInstall
      '';
    };

  dcd-server = buildDcd "server";
  dcd-client = buildDcd "client";
in
{
  config = lib.mkIf (cfg.enable && cfg.dlang) {
    plugins.lsp.servers.serve_d = {
      enable = true;

      # Once serve-d updates to 0.8, I'll have to redo this patch
      # Just clone serve-d and grep for "outdated"
      package = pkgs.serve-d.overrideAttrs {
        patches = [ ./serve-d-allow-locally-compiled-dcd.patch ];
      };

      settings.d = {
        dcdServerPath = "${dcd-server}/bin/dcd-server";
        dcdClientPath = "${dcd-client}/bin/dcd-client";
      };
    };
  };
}
