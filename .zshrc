if [ -e ~/.zshrc.local.preload ]; then
  source ~/.zshrc.local.preload
fi

# Adapted from code found at <https://gist.github.com/1712320>.

export PATH=$HOME/.local/bin
export PATH=$PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
export FPATH=~/.zfunc:$FPATH
export NVM_DIR="$HOME/.nvm"
export LC_ALL=zh_TW.UTF-8
export LANG=en_US.UTF-8

export PKG_CONFIG_PATH="/usr/local/opt/zlib/lib/pkgconfig"
export LDFLAGS="-L $(xcrun --show-sdk-path)/usr/lib -L brew --prefix bzip2/lib"
export CFLAGS="-L $(xcrun --show-sdk-path)/usr/include -L brew --prefix bzip2/include"


setopt prompt_subst
autoload -U colors && colors # Enable colors in prompt
export TERM="xterm-256color"

stty -ixon

# Modify the colors and symbols in these variables as desired.
GIT_PROMPT_SYMBOL="%{$fg_bold[blue]%}±"
GIT_PROMPT_PREFIX="%{$fg_bold[green]%}[%{$reset_color%}"
GIT_PROMPT_SUFFIX="%{$fg_bold[green]%}]%{$reset_color%}"
GIT_PROMPT_AHEAD="%{$fg_bold[red]%}ANUM%{$reset_color%}"
GIT_PROMPT_BEHIND="%{$fg_bold[cyan]%}BNUM%{$reset_color%}"
GIT_PROMPT_MERGING="%{$fg_bold[magenta]%}⚡︎%{$reset_color%}"
GIT_PROMPT_UNTRACKED="%{$fg_bld[red]%}●%{$reset_color%}"
GIT_PROMPT_MODIFIED="%{$fg_bold[yellow]%}●%{$reset_color%}"
GIT_PROMPT_STAGED="%{$fg_bold[green]%}●%{$reset_color%}"

# Show Git branch/tag, or name-rev if on detached head
parse_git_branch() {
   (git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD) 2> /dev/null
}

# Show different symbols as appropriate for various Git repository states
parse_git_state() {

  # Compose this value via multiple conditional appends.
  local GIT_STATE=""

  local NUM_AHEAD="$(git log --oneline @{u}.. 2> /dev/null | wc -l | tr -d ' ')"
  if [ "$NUM_AHEAD" -gt 0 ]; then
    GIT_STATE=$GIT_STATE${GIT_PROMPT_AHEAD//NUM/$NUM_AHEAD}
  fi

  local NUM_BEHIND="$(git log --oneline ..@{u} 2> /dev/null | wc -l | tr -d ' ')"
  if [ "$NUM_BEHIND" -gt 0 ]; then
    GIT_STATE=$GIT_STATE${GIT_PROMPT_BEHIND//NUM/$NUM_BEHIND}
  fi
  if ! git diff --cached --quiet 2> /dev/null; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_STAGED
  fi

  if [[ -n $GIT_STATE ]]; then
    echo "$GIT_PROMPT_PREFIX$GIT_STATE$GIT_PROMPT_SUFFIX"
  fi

}

# If inside a Git repository, print its branch and state
git_prompt_string() {
  local git_where="$(parse_git_branch)"
  [ -n "$git_where" ] && echo "$GIT_PROMPT_SYMBOL$(parse_git_state)$GIT_PROMPT_PREFIX%{$fg_bold[yellow]%}${git_where#(refs/heads/|tags/)}$GIT_PROMPT_SUFFIX"
}

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob nomatch
unsetopt beep

# Histroy
autoload -Uz history-beginning-search-menu
zle -N history-beginning-search-menu
# bindkey '^X^X' history-beginning-search-menu


# alias and env
export EDITOR=vim

alias 'cd..'='cd ..'
# alias 'cdexercise'=cdexercise
alias 'cddownload'='cd ~/Downloads'
alias 'cddocument'='cd ~/Documents'
alias 'cdssh'='cd ~/.ssh/'
alias 'cdcode'=cdcode
alias 'cdcourse'=cdcourse
alias 'ptt'='ssh bbsu@ptt.cc'
# alias 'me'='ssh me;clear'
alias 'cd-'='cd -'
alias 'sudo'='sudo' # use sudo to not call rmtrash and rmdirtrash
alias 'nosleep'='pmset noidle'
alias 'clmemory'='sudo purge'
# alias 'res'='exec zsh'
alias 'cres'='cls; exec zsh'
# alias 'v'=venv
# alias 'v..'=venvprevious
# alias 'd'='deactivate'
# alias 'doc'='docker-compose'
# alias 'docdown'='docker-compose down'
alias 'vimzsh'='vim ~/.zshrc'
alias 'vimrc'='vim ~/.vimrc'
alias 'pwd'='pwd; pwd | pbcopy'
alias 'open.'='pwd; open .'
alias 'open..'='open ..'
alias cls='clear'
# alias sr='screen -RD'
# alias sd='screen -d'
# alias tmr='tmux attach'
alias ll='ls -al'
alias lsd='ls ~/Downloads/'
alias showusb='camcontrol devlist'
alias grep='grep --color=auto'
# alias 'mvd'=moveFromDownload
# alias 'mtd'=moveToDownload
# alias -s html='vim'
# alias -s rb='vim'
# alias -s erb='vim'
# alias -s py='vim'
# alias -s js='vim'
# alias -s ejs='vim'
# alias -s java='vim'
# alias -s txt='vim'
# alias -s c='vim'
# alias -s cpp='vim'
alias -s '.tar_compress'='tar cvf FileName.tar DirName'
alias -s '.tar_decompress'='tar xvf FileName.tar'
alias -s '.tar.gz_compress'='tar zcvf FileName.tar.gz DirName'
alias -s '.tar.gz_decompress'='tar zxvf FileName.tar.gz'
alias -s '.zip_compress'='zip -r FileName.zip DirName'
alias -s '.zip_decompress'='unzip FileName.zip'
alias res=restartzsh

alias wine='wine64'
autoload -Uz python

function restartzsh {
    if [ -z $1 ]; then
        exec zsh
    elif [ "$1" = "new" ]; then
        rm ~/.zshrc
        ln -s ~/.zshrc.updating ~/.zshrc
        exec zsh
    elif [ "$1" = "old" ]; then
        rm ~/.zshrc
        ln -s ~/.zshrc.stable ~/.zshrc
        exec zsh
    fi
}

function cdcourse {
    if [ -z $1 ]; then
        cd ~/Documents/courses/
    else
        checkAndCd ~/Documents/courses/ $1
    fi
}

function cdcode {
    if [ -z $1 ]; then
        cd ~/Documents/code/
    else
        checkAndCd ~/Documents/code/ $1
    fi
}

function checkAndCd {
    pattern="^"`echo $2 | sed 's/.\{1\}/&[a-z0-9.,_+-]*/g'`
    c=$(ls $1 | grep -Eo "$pattern")
    if [ -z "$c" ]; then
        echo "no dir match $2"
        cd $1
    else
        echo $c
        cd $1$c
    fi
}

function mtd {
    if [ -z $1 ]; then
        echo "need at least two argument"
    else
        mv $1* ~/Downloads
    fi
}

function mvd {
    if [ -z $1 ]; then
        echo "need at least two argument"
    else
        mv ~/Downloads/$1* .
    fi
}

export LS_COLORS=':no=00:fi=00:di=01;31:ln=01;36:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:ex=01;32:*.cmd=01;32:*.exe=01;32:*.com=01;32:*.btm=01;32:*.bat=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.c=01;33:*.cpp=01;33:*.MP3=01;44;37:*.mp3=01;44;37:*.pl=01;33:';
export LSCOLORS='DxGxFxdxCxegedabagacad'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
autoload -Uz compinit
compinit



# Platform-dependent settings
uname=`uname`
if [[ $uname == "Linux" ]]; then
  alias ls='ls --color=auto'
  first_ip=`ip addr | sed -e '/127\.0\.0\.1/d' | awk '/inet .*/{print $2}' | sed 1q | awk -F/ '{print $1}'`
elif [[ $uname =~ "CYGWIN_NT" ]]; then
  alias ls='ls --color=auto'
  first_ip=`ipconfig | sed -n -e '/IPv4/p' | awk -F": " '{print $2}' | sed -e '/6\.1\.1\.1/d' | sed -e '/^169\.254/d' | sed '1q;d' | tr -d "\r\n"`
else
  alias ls='ls -G'
  first_ip=`ifconfig | sed -e '/127\.0\.0\.1/d' | awk '/inet .* netmask/{print $2}' | sed 1q | sed -n '1,1p'`
fi

if [ -n ${prompt} ]; then
  ip_str='N/A'
  if [ -n ${first_ip} ]; then
    ip_str=${first_ip}
  fi
  window_str=''
  if [ -n "${WINDOW}" ]; then
    window_str="[S${WINDOW}]"
  fi
  if [ -n "${TMUX_PANE}" ]; then
    window_str="[T`tmux display-message -p '#I'`]$window_str"
  fi
  if [ -z "$window_str" ]; then
    window_str="['-']"
  fi
  prompt='%{$fg_bold[cyan]%}%T %{$fg_bold[yellow]%}%n%{$reset_color%}@%{$fg_bold[white]%}%m%{$reset_color%}%{$fg_bold[red]%}($ip_str)%{$fg_bold[green]%}[%~]%{$reset_color%} $(git_prompt_string)
%{$fg_bold[magenta]%}$window_str %{$reset_color%}%# '
fi


if [ -e ~/.zshrc.local ]; then
  source ~/.zshrc.local
fi

# screenfetch -E
ls -l ~/.zshrc | awk '{print $11}'

