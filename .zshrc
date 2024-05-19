# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If macos
if [[ "$(uname)" == "Darwin" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Set directoy zinit will be installed to.
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Install zinit if it is not already installed.
if [ ! -d "${ZINIT_HOME}" ]; then
  mkdir -p "$(dirname "${ZINIT_HOME}")"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Load zinit.
source "${ZINIT_HOME}/zinit.zsh"

## Load plugins

# load powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k
# load syntax highlighting
zinit ice depth=1; zinit light zsh-users/zsh-syntax-highlighting
# load autosuggestions
zinit ice depth=1; zinit light zsh-users/zsh-autosuggestions
# load auto completions
zinit ice depth=1; zinit light zsh-users/zsh-completions
autoload -U compinit && compinit
# load fuzzyfinder tab completion
zinit ice depth=1; zinit light Aloxaf/fzf-tab

# Add omzsh plugins
zinit snippet OMZP::git
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx

# Load completions

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# History settings
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups

# Completion style settings
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" # ls colors
zstyle ':completion:*' menu no # no menu completion
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath' # fzf-tab preview

# Enable kubectl shell completion
source <(kubectl completion zsh)

# Aliases
source ~/.alias

# Enable fuzzyfinder shell integration
eval "$(fzf --zsh)"

