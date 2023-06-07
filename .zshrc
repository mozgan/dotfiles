# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# --- exports ---
export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH
export PATH=$HOME/bin:$HOME/.local/bin:$HOME/.local/sbin:$PATH
export PATH="/usr/local/opt/llvm/bin:$PATH"

#export LDFLAGS="-L/usr/local/opt/llvm/lib/c++ -Wl,-rpath,/usr/local/opt/llvm/lib/c++"
export LDFLAGS="-L/usr/local/opt/llvm/lib"
export CPPFLAGS="-I/usr/local/opt/llvm/include"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

#export DATE=$(date +%Y-%m-%d)

# language environment
export LANG=en_US.UTF-8

ZSH_THEME="powerlevel10k/powerlevel10k"

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

DEFAULT_USER=$(whoami)

plugins=(colored-man-pages common-aliases copybuffer extract \
        docker git gitignore git-extras gitfast git-prompt \
        python pyenv sudo vi-mode macos \
        zsh-interactive-cd zsh-navigation-tools zsh-syntax-highlighting \
        zsh-autosuggestions zsh-completions)

# --- --- -- Completion --- --- --- #

# load completions system
zmodload -i zsh/complist

# auto rehash commands
zstyle ':completion:*' rehash true

# for all completions: menuselection
zstyle ':completion:*' group-name ''

# for all completions: color
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# completion of .. directories
zstyle ':completion:*' special-dirs true

# case insensitivity
zstyle ":completion:*" matcher-list 'm:{A-Zöäüa-zÖÄÜ}={a-zÖÄÜA-Zöäü}'

# for all completions: grouping / headline / ...
zstyle ':completion:*:messages' format $'\e[01;35m -- %d -- \e[00;00m'
zstyle ':completion:*:warnings' format $'\e[01;31m -- No Matches Found -- \e[00;00m'
zstyle ':completion:*:descriptions' format $'\e[01;33m -- %d -- \e[00;00m'
# https://thevaluable.dev/zsh-completion-guide-examples/
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'

# statusline for many hits
zstyle ':completion:*:default' select-prompt $'\e[01;35m -- Match %M    %P -- \e[00;00m'

# for all completions: show comments when present
zstyle ':completion:*' verbose yes

# case-insensitive -> partial-word (cs) -> substring completion:
zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# caching of completion stuff
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$ZSH_CACHE"

# ~dirs: reorder output sorting: named dirs over userdirs
zstyle ':completion::*:-tilde-:*:*' group-order named-directories users

# rm: advanced completion (e.g. bak files first)
#zstyle ':completion::*:rm:*:*' file-patterns '*.o:object-files:object\ file *(~|.(old|bak|BAK)):backup-files:backup\ files *~*(~|.(o|old|bak|BAK)):all-files:all\ files'

# vi: advanced completion (e.g. tex and rc files first)
zstyle ':completion::*:vi:*:*' file-patterns 'Makefile|*(rc|log)|*.(php|tex|bib|sql|zsh|ini|sh|vim|rb|sh|js|tpl|csv|rdf|txt|phtml|tex|py|n3):vi-files:vim\ likes\ these\ files *~(Makefile|*(rc|log)|*.(log|rc|php|tex|bib|sql|zsh|ini|sh|vim|rb|sh|js|tpl|csv|rdf|txt|phtml|tex|py|n3)):all-files:other\ files'

# command for zsh-completions
autoload -U compinit && compinit

# --- --- --- . --- --- --- #
source $ZSH/oh-my-zsh.sh

# User configuration

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS
SAVEHIST=10000
HISTSIZE=12000

# no share history
setopt no_share_history hist_ignore_space
unsetopt share_history

# If a command is issued that can’t be executed as a normal command, and the command is the name of a directory, perform the cd command to that directory.
setopt AUTO_CD
setopt AUTO_PUSHD
setopt CHASE_DOTS

# Treat  the ‘#’, ‘~’ and ‘^’ characters as part of patterns for filename generation, etc.  (An initial unquoted ‘~’ always produces named directory expansion.)
setopt EXTENDED_GLOB

# If a pattern for filename generation has no matches, print an error, instead of leaving it unchanged in the argument  list. This also applies to file expansion of an initial ‘~’ or ‘=’.
setopt NOMATCH

# no Beep on error in ZLE.
setopt NO_BEEP

setopt HASH_CMDS
setopt COMBININGCHARS

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  if [ -x "$(command -v nvim)" ]; then
    export EDITOR='nvim'
  else
    export EDITOR='mvim'
  fi
fi

# --- Alias settings ---
alias grep='grep --color=auto'

if [ -x "$(command -v trash)" ]; then
  alias rm='echo -e "\n\e[1;41mPlease do NOT fucking use rm command! Use trash FILES, instead." && false'
  alias trash-rm='trash -s'
  alias trash-list='trash -l'
  alias trash-empty='trash -sy'
fi

#if [ -x "$(command -v colorls)" ]; then
#  alias ls="colorls"
#  alias la="colorls -al"
#fi

if [ -x "$(command -v exa)" ]; then
  alias ls="exa --icons --group --group-directories-first --octal-permissions --classify"
  #alias ls=' exa --group-directories-first'
  alias ll="clear; exa --icons --git -h -l --group-directories-first --time-style long-iso --color automatic"
  alias tree="ls --tree"
fi

if [ -x "$(command -v thefuck)" ]; then
    alias fuck='fuck -y'
fi

if [ -x "$(command -v cmake)" ]; then
  alias cbuild='cmake .. && make -j'
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#if [[ "$(command -v fortune)" && "$(command -v cowsay)" && "$(command -v lolcat)" ]]; then
#  fortune -s computers | cowsay -f daemon | lolcat
#fi
