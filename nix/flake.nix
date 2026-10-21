{
  description = "yanguk nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nix-darwin,
      nix-homebrew,
    }:
    let
      username = "yangukheo";
    in
    {
      # $ darwin-rebuild build --flake .#yanguk
      darwinConfigurations.yanguk = nix-darwin.lib.darwinSystem {
        specialArgs = {
          inherit username;
          inherit inputs;
        };
        modules = [
          ./configuration.nix
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              # User owning the Homebrew prefix
              user = username;

              # Automatically migrate existing Homebrew installations
              autoMigrate = true;
              # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
              enableRosetta = true;
            };
          }
        ];
      };
    };
}
