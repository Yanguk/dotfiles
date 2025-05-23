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
sudo darwin-rebuild switch --flake ~/.config/nix#yanguk
```

# zsh

```bash
ln -sf ~/.config/zsh/.zshrc ~/.zshrc
```

# delta-theme

https://github.com/catppuccin/bat

bat cache --build

# keyboard lazyout

## Add colemak-dh

[github](https://github.com/ColemakMods/mod-dh)

1. brew Colemak

## 구름 입력기

Add `Han 3set Shin P2`
https://github.com/gureum/gureum

# Nvim Ai

## vectorcode

- pipx install vectorcode

## MCP

[tavily](https://tavily.com/)

```bash
echo "export TAVILY_API_KEY=''" >> ~/.zprofile
```

# Rust

https://www.rust-lang.org/tools/install
