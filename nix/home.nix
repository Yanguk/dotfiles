{ config, pkgs, ... }:
let
  username = "yangukheo";
in
{
  home.username = username;
  home.homeDirectory = "/Users/${username}";

  # User-level packages
  home.packages = with pkgs; [
    # images
    imagemagick # nvim_snack.image
    pngpaste # nvim_img-clip

    lazygit
    bottom
    yazi

    nixfmt-rfc-style
    delta
    bat
    fzf
    terraform
    awscli2
    ripgrep

    wget
    gnupg
    gh
    ddgr

    deno
    bun
    zig

    codecrafters-cli
    raycast

    nerd-fonts.hack
    noto-fonts-cjk-sans
  ];

  # Zsh configuration
  programs = {
    zsh = {
      enable = true;
      initContent = ''
        [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

        # GPG
        export GPG_TTY=$TTY

        # nvm
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
        [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

        # yazi auto-cd function
        yz() {
            local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
            yazi "$@" --cwd-file="$tmp"
            if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
                builtin cd -- "$cwd"
            fi
            rm -f -- "$tmp"
        }
      '';
      shellAliases = {
        # lazyGit
        lg = "lazygit";
        # Neovim
        vi = "nvim";
        # Timezone
        tzU = "sudo ln -sf /usr/share/zoneinfo/UTC /etc/localtime";
        tzR = "sudo ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime";
        # aws-profile-change
        awspf = ''export AWS_PROFILE=$(sed -n -E "s/\\[(profile )?([^][]+)\\]?\\s*$/\\2/p" ~/.aws/credentials ~/.aws/config | sort -rg | uniq | fzf)'';

        nixEdit = "nvim ~/.config/nix/flake.nix";
        nixUpdate = "sudo nix flake update --flake ~/.config/nix";
        nixSwitch = "sudo darwin-rebuild switch --flake ~/.config/nix#yanguk";
        nixUpgrade = "sudo determinate-nixd upgrade";
        pss = ''pnpm run $(cat package.json | jq -r '.scripts | keys[]' | fzf)'';
        nss = ''npm run $(cat package.json | jq -r '.scripts | keys[]' | fzf)'';
        yss = ''yarn run $(cat package.json | jq -r '.scripts | keys[]' | fzf)'';
      };
      antidote = {
        plugins = [
          # default는 kind:zsh
          "romkatv/powerlevel10k kind:zsh"
          "ntnyq/omz-plugin-pnpm"
          "zsh-users/zsh-autosuggestions"

          "zdharma-continuum/fast-syntax-highlighting kind:defer"
          "ohmyzsh/ohmyzsh path:plugins/git"
        ];
        enable = true;
      };

      setOptions = [
        # 공백으로 시작하는 명령어는 history에 저장하지 않음
        "HIST_IGNORE_SPACE"
      ];
    };

    direnv.enable = true;
    zoxide.enable = true;

    lazygit = {
      enable = true;
      settings = {
        git = {
          paging = {
            colorArg = "always";
            pager = "delta --dark --paging=never --tabs=2 -s";
          };
          commit = {
            signOff = true;
          };
        };
        gui = {
          theme = {
            activeBorderColor = [
              "#89b4fa"
              "bold"
            ];
            inactiveBorderColor = [ "#a6adc8" ];
            optionsTextColor = [ "#89b4fa" ];
            selectedLineBgColor = [ "#313244" ];
            cherryPickedCommitBgColor = [ "#45475a" ];
            cherryPickedCommitFgColor = [ "#89b4fa" ];
            unstagedChangesColor = [ "#f38ba8" ];
            defaultFgColor = [ "#cdd6f4" ];
            searchingActiveBorderColor = [ "#f9e2af" ];
          };
          authorColors = {
            "*" = "#b4befe";
          };
        };
      };
    };
  };
  # # Starship prompt
  # programs.starship = {
  #   enable = true;
  # };
  #
  # # Git configuration
  # programs.git = {
  #   enable = true;
  #   userName = "yanguk";
  #   userEmail = "yangukheo@gmail.com";
  # };

  # Dotfiles example (uncomment if needed)
  # home.file = {
  #   ".gitconfig" = {
  #     source = ./dotfiles/gitconfig;
  #   };
  # };

  # Home-manager version
  home.stateVersion = "25.05";

  # 환경변수 및 경로 설정
  home.sessionVariables = {
    LANG = "en_US.UTF-8";
    NVM_DIR = "$HOME/.nvm";
  };
  home.sessionPath = [
    "/opt/homebrew/opt/openjdk/bin"
    "$HOME/.local/bin"
  ];
}
