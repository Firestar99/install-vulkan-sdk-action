{
  description = "install-vulkan-sdk-action";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    inputs:
    inputs.flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import inputs.nixpkgs { inherit system; };
      in {
        devShells.default = pkgs.mkShell {
          # create an environment with nodejs, pnpm, and yarn
          packages = with pkgs; [
            nodejs_24
            nodePackages.pnpm
            (yarn.override { nodejs = nodejs_24; })
          ];
          BIOME_BINARY = "${pkgs.biome}/bin/biome";
        };
      });
}