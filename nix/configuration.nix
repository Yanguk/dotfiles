{ pkgs, ... }:
let
  username = "yanguk";
in
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

  homebrew = {
    enable = true;
    brews = [
      # "awscli-local"
      "neovim"
      # lang
      "mas"
    ];
    casks = [
      # "alacritty"
      # "zed"
      # "zen"
      "duckduckgo"
      "orbStack"
      "figma"
      "google-chrome"
      "obsidian"
      "slack"
      "rectangle"
      "hammerspoon"
      "visual-studio-code"
      "ghostty"
      "dbeaver-community"
    ];
    masApps = {
      "kakaotalk" = 869223134;
      # "adguard-for-safari" = 1440147259;
    };
    onActivation.cleanup = "zap";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
  };

  system = {
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
}
