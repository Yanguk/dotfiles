{
  description = "yanguk nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    # home-manager.url = "github:nix-community/home-manager";
    # home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      nix-homebrew,
    # home-manager,
    }:
    let
      username = "yanguk";
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#yanguk
      darwinConfigurations.${username} = nix-darwin.lib.darwinSystem {
        modules = [
          ./configuration.nix
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              # User owning the Homebrew prefix
              user = username;
            };
          }
          # home-manager.darwinModules.home-manager
          # ./home.nix
        ];
      };
    };
}
