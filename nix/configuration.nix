# cSpell:disable
{ pkgs, username, ... }:
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
    imagemagick # for nvim_snack.image
    # pngpaste # for nvim_img-clip

    lazygit
    bottom
    yazi
    neovim
    # tmux
    zellij
    # stu # aws s3 tui

    nixfmt-rfc-style
    delta
    bat
    # direnv
    fzf
    awscli2
    ripgrep
    wget
    gnupg
    gh
    ddgr
    zoxide
    antidote

    deno
    bun
    volta
    # rustup
    # git
    jujutsu
    jjui

    codecrafters-cli
    # pipx
    # ollama

    postgresql
    boundary
    terraform
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.hack
    noto-fonts-cjk-sans # for ghostty
  ];

  homebrew = {
    enable = true;
    taps = [
      "hashicorp/tap" # office
    ];
    brews = [
      "direnv"
      "zig"
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
      # "beekeeper-studio"
      # "gemini-cli"
      "antigravity"

      "hashicorp-boundary-desktop" # office
      "openvpn-connect" # office
    ];
    onActivation.cleanup = "zap";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
  };

  programs.zsh = {
    enable = true;
    enableBashCompletion = false;
    enableCompletion = false;
    variables = {
      ZDOTDIR = "$HOME/.config/zsh";
    };
    promptInit = ''
      fpath=(${pkgs.antidote}/share/antidote/functions $fpath)
      autoload -Uz antidote
    '';
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

      # dock = {
      #   autohide = true;
      #   show-recents = false;
      #   autohide-delay = 0.03;
      #   autohide-time-modifier = 0.03;
      #   # launchanim = true;
      #   orientation = "bottom";
      #   # tilesize = 48;
      # };
    };
  };
}
