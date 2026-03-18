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

# nvim

## Swift treesitter parser

Swift 파서는 upstream([alex-pinkus/tree-sitter-swift](https://github.com/alex-pinkus/tree-sitter-swift))이 `src/parser.c`를 커밋하지 않아 자동 설치가 불가능하므로 수동 설치 필요.

`TSUpdate` 후에도 parser가 날아가면 아래 스크립트 실행:

```bash
~/.config/nvim/scripts/install-swift-parser.sh
```

# tmux
[tpm](https://github.com/tmux-plugins/tpm)

[theme](https://github.com/catppuccin/tmux)
