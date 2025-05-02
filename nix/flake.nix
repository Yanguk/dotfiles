{
  description = "yanguk nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      nix-homebrew,
    }:
    let
      username = "yanguk";
      configuration =
        { pkgs, ... }:
        {
          nix = {
            enable = false;
            settings = {
              experimental-features = "nix-command flakes";
            };
          };

          nixpkgs = {
            config = {
              allowUnfree = true;
            };
            hostPlatform = "aarch64-darwin";
          };

          environment.systemPackages = with pkgs; [
            # images
            # imagemagick # image.nvim
            # pngpaste # avante.nvim
            # ueberzugpp # yazi, image.nvim

            # zsh
            zsh-fast-syntax-highlighting
            zsh-autosuggestions
            oh-my-zsh
            zoxide

            # TUI app
            tmux
            zellij
            lazygit
            bottom
            yazi
            stu

            # util
            nixfmt-rfc-style
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
            ddgr

            # lang
            uv
          ];

          fonts.packages = with pkgs; [
            nerd-fonts.hack
          ];

          homebrew = {
            enable = true;
            brews = [
              "awscli-local"
              "neovim"
              "codecrafters-io/tap/codecrafters"
              # lang
              "zig"
              "rustup"
              "nvm"
            ];
            casks = [
              "duckduckgo"
              "orbStack"
              "figma"
              "google-chrome"
              "obsidian"
              "slack"
              "raycast"
              "rectangle"
              "hammerspoon"
              "visual-studio-code"
              "alacritty"
              "zed"
              "ghostty"
              "font-noto-sans-cjk-kr" # for ghostty
            ];
            masApps = {
              "kakaotalk" = 869223134;
            };
            onActivation.cleanup = "zap";
            onActivation.autoUpdate = true;
            onActivation.upgrade = true;
          };

          system = {
            # Set Git commit hash for darwin-version.
            configurationRevision = self.rev or self.dirtyRev or null;

            # Used for backwards compatibility, please read the changelog before changing.
            # $ darwin-rebuild changelog
            stateVersion = 6;

            keyboard = {
              enableKeyMapping = true;
              remapCapsLockToControl = true;
            };

            defaults = {
              trackpad = {
                Clicking = true;
                TrackpadThreeFingerDrag = true;
              };

              controlcenter = {
                BatteryShowPercentage = true;
              };

              NSGlobalDomain = {
                # 120, 90, 60, 30, 12, 6, 2
                KeyRepeat = 2;

                # 120, 94, 68, 35, 25, 15
                InitialKeyRepeat = 15;
                "com.apple.mouse.tapBehavior" = 1;
                "com.apple.sound.beep.volume" = 0.0;
                "com.apple.sound.beep.feedback" = 0;

                NSAutomaticQuoteSubstitutionEnabled = false;
                NSAutomaticDashSubstitutionEnabled = false;
                ApplePressAndHoldEnabled = false;
              };

              CustomUserPreferences = {
                "org.hammerspoon.Hammerspoon" = {
                  MJConfigFile = "~/.config/hammerspoon/init.lua";
                };
              };
            };
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
              enable = true;
              # User owning the Homebrew prefix
              user = username;
            };
          }
        ];
      };
    };
}
