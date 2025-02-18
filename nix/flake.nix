{
  description = "yanguk nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
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
      configuration =
        { pkgs, ... }:
        {
          nix.enable = false;
          nixpkgs.config = {
            allowUnfree = true;
          };

          # List packages installed in system profile. To search by name, run:
          # $ nix-env -qaP | grep wget
          environment.systemPackages = with pkgs; [
            neovim
            tmux

            zsh-fast-syntax-highlighting
            zsh-autosuggestions
            oh-my-zsh
            autojump

            nixfmt-rfc-style
            lazygit
            delta
            bat
            direnv
            fzf
            terraform
            terraform-local
            awscli2
            ripgrep
            wget
            gnupg
            gh

            deno
            rustup

            # casks
            google-chrome
            alacritty
            obsidian
            slack
            raycast
            rectangle
            vscode
          ];

          fonts.packages = with pkgs; [
            nerd-fonts.hack
          ];

          homebrew = {
            enable = true;
            brews = [
              "awscli-local"
              "nvm"
            ];
            casks = [
              "duckduckgo"
              "orbStack"
            ];
            masApps = {
              "kakaotalk" = 869223134;
            };
            onActivation.cleanup = "zap";
            onActivation.autoUpdate = true;
            onActivation.upgrade = true;
          };

          # Necessary for using flakes on this system.
          nix.settings.experimental-features = "nix-command flakes";

          # Enable alternative shell support in nix-darwin.
          # programs.fish.enable = true;

          # Set Git commit hash for darwin-version.
          system.configurationRevision = self.rev or self.dirtyRev or null;

          # Used for backwards compatibility, please read the changelog before changing.
          # $ darwin-rebuild changelog
          system.stateVersion = 6;

          # The platform the configuration will be used on.
          nixpkgs.hostPlatform = "aarch64-darwin";

          system.defaults = {
          };
        };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#yanguk
      darwinConfigurations.${username} = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              # Install Homebrew under the default prefix
              enable = true;

              # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
              enableRosetta = true;

              # User owning the Homebrew prefix
              user = username;
            };
          }
          # home-manager.darwinModules.home-manager
          # {
          #   users.users.${username} = {
          #     name = username;
          #     home = "/Users/${username}";
          #   };
          #   home-manager.useGlobalPkgs = true;
          #   home-manager.useUserPackages = true;
          #   home-manager.users.${username} = import ./home.nix;
          # }
        ];
      };
    };
}
