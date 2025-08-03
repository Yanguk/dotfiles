{ pkgs, ... }:
let
  username = "yangukheo";
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

  environment.systemPackages = with pkgs; [
    ## IMAGES
    imagemagick # nvim_snack.image
    pngpaste # nvim_img-clip

    ## TUI APP
    # tmux
    # zellij
    lazygit
    bottom
    yazi
    # stu

    ## UTIL
    nixfmt-rfc-style
    delta
    bat
    direnv
    fzf
    terraform
    # terraform-local
    awscli2
    ripgrep
    wget
    gnupg
    gh
    ddgr
    zoxide

    ## LANG
    deno
    bun
    zig
    volta
    # uv
    # pipx

    ## ETC
    codecrafters-cli
    mas
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.hack
    noto-fonts-cjk-sans # for ghostty
  ];

  homebrew = {
    enable = true;
    brews = [
      "neovim"
      "antidote"
    ];
    casks = [
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
      "raycast"
    ];
    masApps = {
      "kakaotalk" = 869223134;
    };
    onActivation.cleanup = "zap";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
  };

  system = {
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
