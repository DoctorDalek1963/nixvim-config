_default:
    @just --list

# regenerate the flake with flake-file and re-lock it
[group("maintenance")]
write-flake:
    nix run {{ justfile_directory() }}#write-flake --show-trace
    nix flake lock
