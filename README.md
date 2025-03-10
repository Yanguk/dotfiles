# install nix

[nix guide](https://zero-to-nix.com)

````bash
# https://github.com/DeterminateSystems/nix-installer?tab=readme-ov-file#determinate-nix-installer
```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | \
  sh -s -- install --determinate
````

# https://github.com/LnL7/nix-darwin

### nix-darwin install & switch

```bash
nix run nix-darwin/master#darwin-rebuild -- switch --flake ~/.config/nix#yanguk
```

### run switch

```bash
darwin-rebuild switch --flake ~/.config/nix#yanguk
```

# zsh

```bash
ln -sf ~/.config/zsh/.zshrc ~/.zshrc
```

# delta-theme

https://github.com/catppuccin/bat

```bash
bat cache --build
```

# Add colemak-dh

[github](https://github.com/ColemakMods/mod-dh)

1. download Colemak

2. cp -r Colemak\ DH.bundle ~/Library/Keyboard\ Layouts

# 구름 입력기

Add `Han 3set Shin P2`
https://github.com/gureum/gureum
