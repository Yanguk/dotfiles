{
  description = "yanguk nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
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
        ];
      };
    };
}
