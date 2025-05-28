(( ${+commands[direnv]} )) && emulate zsh -c "$(direnv export zsh)"

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

(( ${+commands[direnv]} )) && emulate zsh -c "$(direnv hook zsh)"

export LANG=en_US.UTF-8

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# omz plugins
plugins=(
    pnpm
    yarn
    git
    gh
    docker
    # tmux

    zoxide
    zsh-autosuggestions
    fast-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# gpg
export GPG_TTY=$TTY

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# lazyGit
export XDG_CONFIG_HOME="$HOME/.config"
alias lg="lazygit"

# Neovim
alias vi="nvim"

# Timezone
alias tzU="sudo ln -sf /usr/share/zoneinfo/UTC /etc/localtime"
alias tzR="sudo ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime"

# aws-profile-change
alias awspf='export AWS_PROFILE=$(sed -n -E "s/\[(profile )?([^][]+)\]?\s*$/\2/p" ~/.aws/credentials ~/.aws/config | sort -rg | uniq | fzf)'

# java
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

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

# package.json의 scripts 읽어서 fzf로 선택하여 실행
alias pss="pnpm run \$(cat package.json | jq -r '.scripts | keys[]' | fzf)"
alias nss="npm run \$(cat package.json | jq -r '.scripts | keys[]' | fzf)"
alias yss="yarn run \$(cat package.json | jq -r '.scripts | keys[]' | fzf)"

# 공백으로 시작하는 명령어는 history에 저장하지 않음 -> ddgr 사용시 히스토리 안남게하기 위함
setopt HIST_IGNORE_SPACE

# Created by `pipx` on 2025-05-23 07:43:15
export PATH="$PATH:/Users/yanguk/.local/bin"

# indicator
function _show_spinner() {
    local pid=$1
    local spinner=("⠋" "⠙" "⠹" "⠸" "⠼" "⠴" "⠦" "⠧" "⠇" "⠏")
    local i=0

    local cyan="\033[36m" # 청록색
    local reset="\033[0m" # reset


    if [[ -z "$pid" ]]; then
        echo "No PID provided. Running spinner for 3 seconds..."

        echo -ne "\033[s\033[?25l"

        for _ in {1..30}; do
            # Restore the cursor position, set cyan color, and print the spinner
            echo -ne "\033[u${cyan}${spinner[i]}${reset}"

            i=$(( (i + 1) % ${#spinner[@]} ))
            sleep 0.1
        done

        # Clear spinner line, restore cursor position, and show the cursor
        echo -ne "\033[u \033[u\033[?25h"
        return
    fi

    # Save the cursor position and hide the cursor
    echo -ne "\033[s\033[?25l"

    while kill -0 "$pid" 2>/dev/null; do
        # Restore the cursor position, set cyan color, and print the spinner
        echo -ne "\033[u${cyan}${spinner[i]}${reset}"

        i=$(( (i + 1) % ${#spinner[@]} ))
        sleep 0.1
    done

    # Clear spinner line, restore cursor position, and show the cursor
    echo -ne "\033[u \033[u\033[?25h"
}

######## knorwe ########
function dumboPr() {
    if [ -z "$1" ]; then
        echo "Usage: createPR <TITLE>"
        return 1
    fi

    TITLE=$1
    BASE_BRANCH="dumbo/dev"
    REVIEWERS="kimch3617,KIMSeHyung,dkssud9556,cheol-95,jh5391,aihua42"
    LABEL="dumbo"

    # Find the Git root directory
    GIT_ROOT=$(git rev-parse --show-toplevel 2>/dev/null)
    if [ -z "$GIT_ROOT" ]; then
        echo "Not inside a Git repository."
        return 1
    fi

    # Read the template file
    TEMPLATE_FILE="$GIT_ROOT/.github/PULL_REQUEST_TEMPLATE.md"
    if [ ! -f "$TEMPLATE_FILE" ]; then
        echo "Template file not found: $TEMPLATE_FILE"
        return 1
    fi

    TEMPLATE_BODY=$(cat "$TEMPLATE_FILE")

    echo -n "Creating pull request..."
    # Create the PR
    PR_URL=$(gh pr create --assignee "@me" --base "$BASE_BRANCH" --title "$TITLE" --body "$TEMPLATE_BODY" --reviewer "$REVIEWERS" --label "$LABEL")

    local gh_pid=$!

    # Show spinner while the command is running
    _show_spinner "$gh_pid"
    wait "$gh_pid"

    if [ -n "$PR_URL" ]; then
        echo "\nPull request created: $PR_URL"
        open "$PR_URL"
    else
        echo "\nFailed to create the pull request."
        return 1
    fi
}
