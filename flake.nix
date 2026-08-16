{
  description = "Demery Personal Website Development Flake";

  inputs = { nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; };

  outputs = { self, nixpkgs }:
    let
      inherit (nixpkgs.lib) genAttrs;
      supportedSystems = [
        "aarch64-darwin"
        "x86_64-darwin"
        "x86_64-linux"
      ];
      forAllSystems = f: genAttrs supportedSystems (system: f system);
    in {
      devShells = forAllSystems (system:
        let
          pkgs = import nixpkgs { inherit system; };
          # pkgs.nodejs tracks the current LTS line; `nix flake update` +
          # `sync-node-version` moves the whole repo to the latest LTS.
          nodejs = pkgs.nodejs;
          # Pins .nvmrc and package.json engines.node to the flake's node version.
          sync-node-version = pkgs.writeShellScriptBin "sync-node-version" ''
            set -euo pipefail
            if [ ! -f package.json ] || [ ! -f .nvmrc ]; then
              echo "error: run from the repository root" >&2
              exit 1
            fi
            version="${nodejs.version}"
            echo "$version" > .nvmrc
            ${pkgs.gnused}/bin/sed -i -E "s/(\"node\": \")[0-9.]+(\")/\1$version\2/" package.json
            # Only the root package entry pins an exact node version; dependency
            # engines use ranges and are left untouched.
            ${pkgs.gnused}/bin/sed -i -E "0,/(\"node\": \")[0-9.]+(\")/ s//\1$version\2/" package-lock.json
            echo "Pinned node $version in .nvmrc, package.json and package-lock.json"
          '';
        in {
          default = pkgs.mkShell {
            buildInputs = with pkgs; [
              doppler
              nodejs
              sync-node-version
            ];
          };
        });
    };
}
