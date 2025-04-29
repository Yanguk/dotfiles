# install nix

[nix guide](https://zero-to-nix.com)

```bash
# https://github.com/DeterminateSystems/nix-installer?tab=readme-ov-file#determinate-nix-installer
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | \
  sh -s -- install --determinate
```

## nix-darwin install & switch

https://github.com/LnL7/nix-darwin

```bash
nix run nix-darwin/master#darwin-rebuild -- switch --flake ~/.config/nix#yanguk
```

## run switch

```bash
darwin-rebuild switch --flake ~/.config/nix#yanguk
```

# zsh

```bash
ln -sf ~/.config/zsh/.zshrc ~/.zshrc
```

# tmux

mkdir -p ~/.config/tmux/plugins/catppuccin
git clone -b v2.1.3 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux

# delta-theme

https://github.com/catppuccin/bat

bat cache --build

# Add colemak-dh

[github](https://github.com/ColemakMods/mod-dh)

1. download Colemak

2. cp -r Colemak\ DH.bundle ~/Library/Keyboard\ Layouts

# 구름 입력기

Add `Han 3set Shin P2`
https://github.com/gureum/gureum

# Nvim avante Ai search-tool

[tavily](https://tavily.com/)

```bash
echo "export TAVILY_API_KEY=''" >> ~/.zprofile
```
