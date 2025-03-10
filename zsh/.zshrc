export LANG=en_US.UTF-8

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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

  direnv
  autojump
  zsh-autosuggestions
  fast-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

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

# gpg
export GPG_TTY=$(tty)

# aws-profile-change
alias awspf='export AWS_PROFILE=$(sed -n -E "s/\[(profile )?([^][]+)\]?\s*$/\2/p" ~/.aws/credentials ~/.aws/config | sort -rg | uniq | fzf)'

# java
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# nix
alias nixEdit="nvim ~/.config/nix/flake.nix"
alias nixUpdate="nix flake update --flake ~/.config/nix"
alias nixSwitch="darwin-rebuild switch --flake ~/.config/nix#yanguk"

function yz() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
