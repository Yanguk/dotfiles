{ config, pkgs, ... }:
let
  username = "yangukheo";
in
{
  home.username = username;
  home.homeDirectory = "/Users/${username}";

  # User-level packages
  home.packages = with pkgs; [
    zoxide
    bat
    ripgrep
    fzf
    lazygit
    bottom
    yazi
    deno
    bun
    zig
    gh
    delta
    codecrafters-cli
    imagemagick
    pngpaste
    nixfmt-rfc-style
    direnv
    wget
    awscli2
    gnupg
    terraform
    raycast
    nerd-fonts.hack
    noto-fonts-cjk-sans
  ];

  # Zsh configuration
  programs.zsh = {
    enable = true;
    oh-my-zsh.enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    shellAliases = {
      ll = "ls -l";
      la = "ls -la";
    };
  };

  # Starship prompt
  programs.starship = {
    enable = true;
  };

  # Git configuration
  programs.git = {
    enable = true;
    userName = "yanguk";
    userEmail = "yangukheo@gmail.com";
  };

  # Dotfiles example (uncomment if needed)
  # home.file = {
  #   ".gitconfig" = {
  #     source = ./dotfiles/gitconfig;
  #   };
  # };

  # Home-manager version
  home.stateVersion = "23.11";
}
