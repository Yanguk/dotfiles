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

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# 3. Plugins (antidote) - static bundle, manual update only!
zsh_plugins=~/.config/zsh/.zsh_plugins

# Ensure the .zsh_plugins.txt file exists so you can add plugins.
[[ -f ${zsh_plugins}.txt ]] || touch ${zsh_plugins}.txt

# Lazy-load antidote from its functions directory.
fpath=($(brew --prefix)/opt/antidote/share/antidote/functions $fpath)
autoload -Uz antidote

# Generate a new static file whenever .zsh_plugins.txt is updated.
if [[ ! ${zsh_plugins}.zsh -nt ${zsh_plugins}.txt ]]; then
    antidote bundle <${zsh_plugins}.txt >|${zsh_plugins}.zsh
fi

# Source your static plugins file.
source ${zsh_plugins}.zsh

# 4. Aliases/functions (after essentials)
# lazyGit
alias lg="lazygit"
# Neovim
alias vi="nvim"
# Timezone
alias tzU="sudo ln -sf /usr/share/zoneinfo/UTC /etc/localtime"
alias tzR="sudo ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime"
# aws-profile-change
alias awspf='export AWS_PROFILE=$(sed -n -E "s/\[(profile )?([^][]+)\]?\s*$/\2/p" ~/.aws/credentials ~/.aws/config | sort -rg | uniq | fzf)'
# nix
alias nixEdit="nvim ~/.config/nix/flake.nix"
alias nixUpdate="sudo nix flake update --flake ~/.config/nix"
alias nixSwitch="sudo darwin-rebuild switch --flake ~/.config/nix#yanguk"
alias nixUpgrade="sudo determinate-nixd upgrade"
# yazi
function yz() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}
# package.json scripts fzf launcher
alias pss="pnpm run \$(cat package.json | jq -r '.scripts | keys[]' | fzf)"
alias nss="npm run \$(cat package.json | jq -r '.scripts | keys[]' | fzf)"
alias yss="yarn run \$(cat package.json | jq -r '.scripts | keys[]' | fzf)"

setopt HIST_IGNORE_SPACE
