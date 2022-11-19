# users generic .zshrc file for zsh(1)

## Environment variable configuration
#
# LANG
#
export LANG=ja_JP.UTF-8
case ${UID} in
0)
  LANG=C
  ;;
esac

typeset -U path PATH
path=(
  ~/bin(N-/)
  /opt/homebrew/bin(N-/)
  /opt/homebrew/sbin(N-/)
  /opt/homebrew/opt/openssl@3/bin(N-/)
  /opt/homebrew/opt/curl/bin(N-/)
  /usr/local/bin(N-/)
  /usr/local/sbin(N-/)
  /usr/local/opt/openssl@3/bin(N-/)
  /usr/bin
  /usr/sbin
  /bin
  /sbin
  ~/Library/Android/sdk/tools(N-/)
  ~/Library/Android/sdk/platform-tools(N-/)
  ~/bin/flutter/bin(N-/)
  /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin(N-/)
)

#export MANPATH=/usr/local/share/man:$MANPATH
#export SVN_EDITOR="vi"
#export HGENCODING="UTF-8"
#export PATH="/usr/local/opt/gettext/bin:$PATH"
#export STUDIO_JDK=/Library/Java/JavaVirtualMachines/jdk1.8.0_25.jdk

# mount the android file image
# function mountDev { hdiutil attach ~/dev/dev.dmg.sparseimage -mountpoint /Volumes/dev; }

# set the number of open files to be 1024
ulimit -S -n 1024

## Default shell configuration
#
# set prompt
#
autoload colors
colors
case ${UID} in
0)
  PROMPT="%{${fg[red]}%}$USER@%m%%%{${reset_color}%} "
#  PROMPT="%B%{${fg[red]}%}%/#%{${reset_color}%}%b "
  PROMPT2="%B%{${fg[red]}%}%_#%{${reset_color}%}%b "
  SPROMPT="%B%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
  [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
    PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"
  RPROMPT="[%~]"
  ;;
*)
#  PROMPT="%U$USER@%m%%%u "
#  PROMPT="%{${fg[green]}%}$USER${reset_color}%}@%m%{${fg[blue]}%}%%${reset_color} "
  PROMPT="%{${fg[green]}%}$USER@%m%%%{${reset_color}%} "
  RPROMPT="%{${fg[blue]}%}[%~]%{${reset_color}%}"
#
#  PROMPT="%{${fg[red]}%}%/%%%{${reset_color}%} "
  PROMPT2="%{${fg[red]}%}%_%%%{${reset_color}%} "
  SPROMPT="%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
  [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
    PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"
  ;;
esac


# auto change directory
#
setopt auto_cd

# auto directory pushd that you can get dirs list by cd -[tab]
#
setopt auto_pushd

# command correct edition before each completion attempt
#
setopt correct

# compacked complete list display
#
setopt list_packed

# no remove postfix slash of command line
#
#setopt noautoremoveslash
setopt auto_remove_slash

# no beep sound when complete list displayed
#
setopt nolistbeep

## Keybind configuration
#
# emacs like keybind (e.x. Ctrl-a goes to head of a line and Ctrl-e goes 
# to end of it)
#
bindkey -e

# historical backward/forward search with linehead string binded to ^P/^N
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end
# NO 'kill-whole-line'
bindkey \^U backward-kill-line

## Command history configuration
#
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt hist_ignore_dups # ignore duplication command history list
setopt share_history # share command history data

setopt hist_ignore_space

## Alias configuration
#
# expand aliases before completing
#
setopt complete_aliases # aliased ls needs if file/dir completions work

alias where="command -v"
alias j="jobs -l"

case "${OSTYPE}" in
freebsd*|darwin*)
#  alias ls="ls -G -w"
  alias ls="gls --color=auto"
  eval `gdircolors ~/.dircolors-solarized/dircolors.256dark`
  ;;
linux*)
  alias ls="ls --color"
  ;;
esac

alias la="ls -a"
alias lf="ls -F"
alias ll="ls -l"
alias lla="ls -la"

alias du="du -h"
alias df="df -h"

alias su="su -l"

alias ssh='ssh -o ServerAliveInterval=60'
alias tmux='tmux -u'
if [ -f /Applications/VLC.app/Contents/MacOS/VLC ]; then
  alias vlc='/Applications/VLC.app/Contents/MacOS/VLC'
fi

#alias vi='/opt/local/bin/vim'

## terminal configuration
#
unset LSCOLORS
case "${TERM}" in
xterm)
  export TERM=xterm-color
  ;;
kterm)
  export TERM=kterm-color
  # set BackSpace control character
  stty erase
  ;;
cons25)
  unset LANG
  export LSCOLORS=ExFxCxdxBxegedabagacad
  export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
  zstyle ':completion:*' list-colors \
    'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
  ;;
esac

# set terminal title including current directory
#
case "${TERM}" in
kterm*|xterm*|screen)
  precmd() {
    echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
  }
  export LSCOLORS=exfxcxdxbxegedabagacad
  export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
  zstyle ':completion:*' list-colors \
    'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
  ;;
esac

## load user .zshrc configuration file
#
[ -f ~/.zshrc.mine ] && source ~/.zshrc.mine

# anyenv
if [ -d $HOME/.anyenv ] ; then
  export PATH="$HOME/.anyenv/bin:$PATH"
  eval "$(anyenv init -)"
#  source ~/.anyenv/envs/rbenv/completions/rbenv.zsh
fi

if [ -f ~/.wp-completion.bash ]; then
  autoload -U +X bashcompinit && bashcompinit
  source ~/.wp-completion.bash
fi


#export PATH="$HOME/.jenv/bin:$PATH"
#eval "$(jenv init -)"

#setopt magic_equal_subst

## Completion configuration
#

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit
  compinit
fi

