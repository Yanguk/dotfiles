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
          system.primaryUser = username;
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
            imagemagick # nvim_snack.image
            # pngpaste # nvim_img-clip

            # zsh
            zsh-fast-syntax-highlighting
            zsh-autosuggestions
            oh-my-zsh
            zoxide

            # TUI app
            # tmux
            # zellij
            lazygit
            bottom
            yazi
            # stu

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
            # uv
            # Install and run Python applications in isolated environments
            # pipx
          ];

          fonts.packages = with pkgs; [
            nerd-fonts.hack
          ];

          homebrew = {
            enable = true;
            brews = [
              # "awscli-local"
              "neovim"
              "codecrafters-io/tap/codecrafters"
              "pngpaste" # nvim_img-clip
              # lang
              "zig"
              "nvm"
              "mas"
            ];
            casks = [
              # "duckduckgo"
              # "alacritty"
              # "zed"
              # "zen"
              # "raycast"
              "orbStack"
              "figma"
              "google-chrome"
              "obsidian"
              "slack"
              "rectangle"
              "hammerspoon"
              "visual-studio-code"
              "ghostty"
              "font-noto-sans-cjk-kr" # for ghostty
              "dbeaver-community"
            ];
            masApps = {
              "kakaotalk" = 869223134;
              "adguard-for-safari" = 1440147259;
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
