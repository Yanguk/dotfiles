# eval "$(zellij setup --generate-auto-start zsh)"
# alias zj="zellij"

ZVM_SYSTEM_CLIPBOARD_ENABLED=true

# # 1. Fastest prompts and lightweight sources early
(( ${+commands[direnv]} )) && emulate zsh -c "$(direnv export zsh)"

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

(( ${+commands[direnv]} )) && emulate zsh -c "$(direnv hook zsh)"

# 2. Essential env and PATH first
export LANG=en_US.UTF-8
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
export XDG_CONFIG_HOME="$HOME/.config"
export GPG_TTY=$TTY

HISTSIZE=10000
SAVEHIST=10000

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# 3. Plugins (antidote) - static bundle, manual update only!
zsh_plugins=${ZDOTDIR}/.zsh_plugins

# Ensure the .zsh_plugins.txt file exists so you can add plugins.
[[ -f ${zsh_plugins}.txt ]] || touch ${zsh_plugins}.txt

# Generate a new static file whenever .zsh_plugins.txt is updated.
if [[ ! ${zsh_plugins}.zsh -nt ${zsh_plugins}.txt ]]; then
    # Lazy-load at nix config.promptInit
    antidote bundle <${zsh_plugins}.txt >|${zsh_plugins}.zsh
fi

# Source your static plugins file.
source ${zsh_plugins}.zsh
source <(jj util completion zsh)

# 4. Aliases/functions (after essentials)
alias lg="lazygit"
alias vi="nvim"
alias tzU="sudo ln -sf /usr/share/zoneinfo/UTC /etc/localtime"
alias tzR="sudo ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime"
alias awspf='export AWS_PROFILE=$(sed -n -E "s/\[(profile )?([^][]+)\]?\s*$/\2/p" ~/.aws/credentials ~/.aws/config | sort -rg | uniq | fzf)'
alias nixUpdate="sudo nix flake update --flake ~/.config/nix"
alias nixSwitch="sudo darwin-rebuild switch --flake ~/.config/nix#yanguk"
alias nixUpgrade="sudo determinate-nixd upgrade"
alias nixClean="nix-collect-garbage -d"

alias pss="pnpm run \$(cat package.json | jq -r '.scripts | keys[]' | fzf)"
alias nss="npm run \$(cat package.json | jq -r '.scripts | keys[]' | fzf)"
alias yss="yarn run \$(cat package.json | jq -r '.scripts | keys[]' | fzf)"
alias bss="bun run \$(cat package.json | jq -r '.scripts | keys[]' | fzf)"

function gccr() {
    local out="a_$(date +%s)"
    gcc -Wall -Wextra "$@" -o "$out" && ./"$out"
    rm -f "$out"
}

setopt HIST_IGNORE_SPACE

function yz() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

function zvm_before_init() {
    # up, down 시 히스토리 substring search
    autoload -U history-search-end
    zle -N history-beginning-search-backward-end history-search-end
    zle -N history-beginning-search-forward-end history-search-end
    # bindkey "^[[A" history-beginning-search-backward-end
    # bindkey "^[[B" history-beginning-search-forward-end

    # zsh-vi-mode
    zvm_bindkey viins '^[[A' history-beginning-search-backward-end
    zvm_bindkey viins '^[[B' history-beginning-search-forward-end
    zvm_bindkey vicmd '^[[A' history-beginning-search-backward-end
    zvm_bindkey vicmd '^[[B' history-beginning-search-forward-end
}

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
