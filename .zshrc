if [ -e ~/.zshrc.local.preload ]; then
  source ~/.zshrc.local.preload
fi

# Adapted from code found at <https://gist.github.com/1712320>.

bindkey -e

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
bindkey '^X^X' history-beginning-search-menu


autoload zkbd


# for tmux-screen nesting
# Home-end
bindkey -s "\e[1~" "\eOH"
bindkey -s "\e[4~" "\eOF"
bindkey -s "\e[H" "\eOH"
bindkey -s "\e[F" "\eOF"

bindkey -s "\e\e[D" "\e[1;3D"
bindkey -s "\e\e[C" "\e[1;3C"

if [[ -e ${ZDOTDIR:-$HOME}/.zkbd/screen-general ]]; then
  source ${ZDOTDIR:-$HOME}/.zkbd/screen-general
fi

[[ -n ${key[Backspace]} ]] && bindkey "${key[Backspace]}" backward-delete-char
[[ -n ${key[Insert]} ]] && bindkey "${key[Insert]}" overwrite-mode
[[ -n ${key[Home]} ]] && bindkey "${key[Home]}" beginning-of-line
[[ -n ${key[PageUp]} ]] && bindkey "${key[PageUp]}" up-line-or-history
[[ -n ${key[Delete]} ]] && bindkey "${key[Delete]}" delete-char
[[ -n ${key[End]} ]] && bindkey "${key[End]}" end-of-line
[[ -n ${key[PageDown]} ]] && bindkey "${key[PageDown]}" down-line-or-history
[[ -n ${key[Up]} ]] && bindkey "${key[Up]}" up-line-or-search
[[ -n ${key[Left]} ]] && bindkey "${key[Left]}" backward-char
[[ -n ${key[Down]} ]] && bindkey "${key[Down]}" down-line-or-search
[[ -n ${key[Right]} ]] && bindkey "${key[Right]}" forward-char


# alias and env
export EDITOR=vim

alias 'cd..'='cd ..'
alias '..'='cd ..'
alias 'cd...'='cd ../..'
alias '...'='cd ../..'
alias 'cd....'='cd ../../..'
alias '....'='cd ../../..'
alias 'cdexercise'=cdexercise
alias 'cddownload'='cd ~/Downloads'
alias 'cddocument'='cd ~/Documents'
alias 'cddeveloper'=cddeveloper
alias 'cdcode'=cdcode
alias 'cdnctuplus'='cd ~/Documents/code/nctuplus-api'
alias 'cdcourse'=cdcourse
alias 'bsd1'='ssh bsd1;clear'
alias 'bsd2'='ssh bsd2;clear'
alias 'bsd3'='ssh bsd3;clear'
alias 'bsd'='ssh bsd;clear'
alias 'linux1'='ssh linux1;clear'
alias 'linux2'='ssh linux2;clear'
alias 'linux3'='ssh linux3;clear'
alias 'linux'='ssh linux3;clear'
alias 'me'='ssh me;clear'
alias 'cd-'='cd -'
# alias 'rm'='rmtrash'
alias 'sudo'='sudo' # use sudo to not call rmtrash and rmdirtrash
alias 'nosleep'='pmset noidle'
alias 'clmemory'='sudo purge'
alias 'res'='exec zsh'
alias 'cres'='cls; exec zsh'
alias 'v'=venv
alias 'v..'=venvprevious
alias 'd'='deactivate'
alias 'docstart'=dockerstart
alias 'doccp'=dockercopy
alias 'doc'='docker-compose'
alias 'docdown'='docker-compose down'
alias 'vimzsh'='vim ~/.zshrc'
alias 'vimrc'='vim ~/.vimrc'
alias 'vimdif'=vimdifferent
alias 'swap'=swapname
alias 'pwd'='pwd; pwd | pbcopy'
alias 'open.'='pwd; open .'
alias 'open..'='open ..'
alias cls='clear'
alias sr='screen -RD'
alias sd='screen -d'
alias tmr='tmux attach'
alias ll='ls -al'
alias lsd='ls ~/Downloads/'
alias grep='grep --color=auto'
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
alias -s gz='tar -zxvf'
alias -s tgz='tar -zxvf'
alias -s zip='unzip'

function cddeveloper {
    if [ -z $1 ]; then
        cd ~/Documents/code/developer/
    else
        cd ~/Documents/code/developer/
        cd case$1
    fi
}

function cdcourse {
    if [ -z $1 ]; then
        cd ~/Documents/courses/
    else
        tmp=`echo $1 | sed 's/.\{1\}/&[a-zA-Z0-9,_-]*/g'`
        tmp="[a-zA-Z0-9,_-]*"$tmp
        c=$(ls ~/Documents/courses/ | grep -Eo "$tmp")
        echo $c
        cd ~/Documents/courses/
        cd $c
        if [ -z $2 ]; then
        else
            cd $2
        fi
    fi
}

function cdcode {
    if [ -z $1 ]; then
        cd ~/Documents/code/
    else
        cd ~/Documents/code/
        cd $1*
        if [ -e venv ]; then 
            source venv/bin/activate
        fi
    fi
}

function cdexercise {
    if [ -z $1 ]; then
        cd ~/Documents/code/python/exercise
    else
        cd ~/Documents/code
        cd $1
        cd exercise
        if [ -e venv ]; then 
            source venv/bin/activate
        fi
    fi
}

function venv {
    if [ -z $1 ]; then
        source venv/bin/activate
    elif [ $1 = ".." ]; then
        source ../venv/bin/activate
    elif [ $1 = "..." ]; then
        source ../../venv/bin/activate
    else
        source $1/bin/activate
    fi
}

function venvprevious {
    if [ -z $1 ]; then
        source ../venv/bin/activate
    else
        source ../$1/bin/activate
    fi   
    
}

function vimdifferent {
    if [ -z $1 ]; then
        echo "need on argument"
    elif [ -z $2 ]; then
        vimdiff $1_1 $1_2
    else
        vimdiff $1 $2
    fi
}

function swapname {
    if [ -z $1 ]; then
        echo "need at least two argument"
    elif [ -z $2 ]; then
        echo "need one more argument"
    elif [ -z $3 ]; then
        mv $1 $1.something.tmp
        mv $2 $1
        mv $1.something.tmp $2
    else
        echo "too much argument"
    fi
}

function dockerstart {
    if [ -z $1 ]; then
        echo "need at least one argument"
    else
        docker start -i $1
    fi
}

function dockercopy {
    if [ -z $1 ]; then
        echo "need at least two argument"
    elif [ -z $2 ]; then
        echo "need one more argument"
    else
        if [[ $1 == *":"* ]]; then
            container_name=$(echo $1| cut -d':' -f1)
            container_id=$(docker container ls -a | grep $container_name | awk '{print $1}')
            real=$(echo $1 | sed -e "s/$container_name/$container_id/" -e "s/~/\/root/")
            docker cp $real $2
        elif [[ $2 == *":"* ]]; then
            container_name=$(echo $2| cut -d':' -f1)
            container_id=$(docker container ls -a | grep $container_name | awk '{print $1}')
            real=$(echo $2 | sed -e "s/$container_name/$container_id/" -e "s/~/\/root/")
            docker cp $1 $real
        fi
#         container_id=`docker container ls -a | grep me | awk '{print $1}'`
#         docker cp
    fi
}

export LS_COLORS=':no=00:fi=00:di=01;31:ln=01;36:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:ex=01;32:*.cmd=01;32:*.exe=01;32:*.com=01;32:*.btm=01;32:*.bat=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.c=01;33:*.cpp=01;33:*.MP3=01;44;37:*.mp3=01;44;37:*.pl=01;33:';
export LSCOLORS='DxGxFxdxCxegedabagacad'
export LC_CTYPE='en_US.UTF-8'
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'
#export LC_CTYPE='zh_TW.Big5'
#export LANG='zh_TW.Big5'
#export LC_ALL='zh_TW.Big5'
# export RUBY_VERSION_PATCH=`ruby -e 'puts "#{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}"'`

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


function zle-line-init {
    marking=0
}
zle -N zle-line-init

function select-char-right {
    if (( $marking != 1 )) 
    then
        marking=1
        zle set-mark-command
    fi
    zle .forward-char
}
zle -N select-char-right

function select-char-left {
    if (( $marking != 1 )) 
    then
        marking=1
        zle set-mark-command
    fi
    zle .backward-char
}
zle -N select-char-left

function forward-char {
    if (( $marking == 1 ))
    then
        marking=0
        NUMERIC=-1 zle set-mark-command
    fi
    zle .forward-char
}
zle -N forward-char

function backward-char {
    if (( $marking == 1 ))
    then
        marking=0
        NUMERIC=-1 zle set-mark-command
    fi
    zle .backward-char
}
zle -N backward-char

function delete-char {
    if (( $marking == 1 ))
    then
        zle kill-region
        marking=0
    else
        zle .delete-char
    fi
}
zle -N delete-char

bindkey '^[[1;3D' select-char-left 
bindkey '^[[1;3C' select-char-right
bindkey "\C-w" delete-char

bindkey "\eOC" forward-word
bindkey "\eOD" backward-word

if [ -e ~/.zshrc.local ]; then
  source ~/.zshrc.local
fi

# screenfetch -E
