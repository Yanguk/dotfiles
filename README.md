# install lix

[lix](https://lix.systems/install/#on-any-other-linuxmacos-system)

## nix-darwin install & switch

[nix-darwin](https://github.com/nix-darwin/nix-darwin)

- install

```bash
sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake ~/.config/nix#yanguk
```

- switch

```bash
sudo darwin-rebuild switch --flake ~/.config/nix#yanguk
```

# keyboard layout

[gurem](https://github.com/gureum/gureum)

- Add `Han 3set Shin P2`

[canary](https://github.com/Apsu/Canary/blob/main/INSTALL.md)

# tmux

[tpm](https://github.com/tmux-plugins/tpm)

[theme](https://github.com/catppuccin/tmux)

# homebrew

[brew](https://brew.sh/)

```bash
brew bundle check --file=~/.config/homebrew/Brewfile
brew bundle install --file=~/.config/homebrew/Brewfile
```

# 에이전트 전역 지침

```bash
echo '@~/.config/agents/AGENT.md' > ~/.codex/AGENTS.md
echo '@~/.config/agents/AGENT.md' > ~/.claude/CLAUDE.md
```

Codex의 `AGENTS.md`는 `@office.md`를 포함하므로 두 파일을 모두 `~/.codex`에서 찾을 수 있어야 한다.
