# install nix

[nix guide](https://zero-to-nix.com)

```bash
# https://github.com/DeterminateSystems/nix-installer?tab=readme-ov-file#determinate-nix-installer
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | \
  sh -s -- install --determinate
```

## nix-darwin install & switch

[nix-darwin](https://github.com/nix-darwin/nix-darwin)

- install

```bash
nix run nix-darwin/master#darwin-rebuild -- switch --flake ~/.config/nix#yanguk
```

- switch

```bash
sudo darwin-rebuild switch --flake ~/.config/nix#yanguk
```

# delta-theme

https://github.com/catppuccin/bat

bat cache --build

# keyboard layout

~~[mod-dh](https://github.com/ColemakMods/mod-dh)~~

[gurem](https://github.com/gureum/gureum)

- Add `Han 3set Shin P2`

[canary](https://github.com/Apsu/Canary/blob/main/INSTALL.md)

# MCP

[tavily](https://tavily.com/)

```bash
echo "export TAVILY_API_KEY=''" >> ~/.zshenv
```

# copilot
https://github.com/github/copilot-cli

```
npm install -g @github/copilot
```
