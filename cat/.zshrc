# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

HOME=${HOME:-"/home/cat"}
# Path to your oh-my-zsh installation.
for ZSH in \
    "/usr/share/oh-my-zsh" \
    "$HOME/.oh-my-zsh"           
do
    if [ -d "$ZSH" ]; then
        export ZSH
        break
    fi
done

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="ys"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  colored-man-pages
  ruby
  cp
  z
  extract
  vi-mode
  sudo
)

if [[ "$OSTYPE" == "darwin"* ]]; then
plugins+=(
  tmux
  zsh-autosuggestions
  osx
  brew
  supervisor
  pass
)
export CLOUDSDK_PYTHON=/usr/bin/python
fi

source $ZSH/oh-my-zsh.sh

ZSH_CACHE_DIR="$HOME/.cache/oh-my-zsh"
if [[ ! -d "$ZSH_CACHE_DIR" ]]; then
  mkdir -p "$ZSH_CACHE_DIR"
fi

# User configuration
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR='vim'


export VAGRANT_DEFAULT_PROVIDER=virtualbox
export VAGRANT_BOX_UPDATE_CHECK_DISABLE=yes
export ANSIBLE_INVENTORY=./hosts


for BREW in \
    "/home/linuxbrew/.linuxbrew/bin" \
    "$HOME/.linuxbrew/bin"           
do
    if [ -d "$BREW" ]; then
        eval "$($BREW/brew shellenv)"
        break
    fi
done

if command -v "brew" 1>/dev/null 2>&1; then
    HOMEBREW_PREFIX=${HOMEBREW_PREFIX:-"/usr/local"}
    HOMEBREW_CELLAR=${HOMEBREW_CELLAR:-"/usr/local/Cellar"}
    HOMEBREW_REPOSITORY=${HOMEBREW_REPOSITORY:-"/usr/local/Homebrew"}
fi

# Language envs
for E in rbenv pyenv nodenv \
         jenv goenv plenv
do
    ENV_ROOT="$HOME/.$E"
    [ -d "$ENV_ROOT/bin" ] && export PATH="$ENV_ROOT/bin:$PATH"
    if command -v "$E" 1>/dev/null 2>&1; then
        eval "$($E init - --no-rehash)"
    fi
done


# Additional PATH
for P in \
    "gnu-sed/libexec/gnubin"    \
    "gnu-tar/libexec/gnubin"    \
    "coreutils/libexec/gnubin"  \
    "findutils/libexec/gnubin"  \
    "gnu-getopt/bin"            \
    "gettext/bin"               \
    "openssl@1.1/bin"           \
    "node@10/bin"               
do
    if [ -d "$HOMEBREW_PREFIX/opt/$P" ]; then
        export PATH="$HOMEBREW_PREFIX/opt/$P:$PATH"
    fi
done


# Optional
for P in \
    "/Applications/Sublime Text.app/Contents/SharedSupport/bin"    \
    "/opt/namecoin/bin"    \
    "$HOME/.local/bin"     \
    "$HOME/.yarn/bin"      \
    "$HOME/.gem/ruby/"*/bin(N)
do
    if [ -d "$P" ]; then
        export PATH="$P:$PATH"
    fi
done


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

# added by travis gem
TRAVIS_DIR="$HOME/.travis"
[ -f "$TRAVIS_DIR/travis.sh" ] && source "$TRAVIS_DIR/travis.sh"

# Google cloud auto completion
GOOGLE_CLOUD_SDK="/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk"
if [ -d "$GOOGLE_CLOUD_SDK" ]
then
    source "$GOOGLE_CLOUD_SDK/path.zsh.inc"
    source "$GOOGLE_CLOUD_SDK/completion.zsh.inc"
fi

if command -v "aws" 1>/dev/null 2>&1
then
    source "$(pyenv which aws_zsh_completer.sh)"
fi

PERL5_DIR="$HOME/perl5"
if [ -d "$PERL5_DIR" ]
then
    eval "$(perl -I"$PERL5_DIR"/lib/perl5 -Mlocal::lib)"
    # PATH="$PERL5_DIR/bin${PATH:+:${PATH}}"; export PATH;
    # PERL5LIB="$PERL5_DIR/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
    # PERL_LOCAL_LIB_ROOT="$PERL5_DIR${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
    # PERL_MB_OPT="--install_base \"$PERL5_DIR\""; export PERL_MB_OPT;
    # PERL_MM_OPT="INSTALL_BASE=$PERL5_DIR"; export PERL_MM_OPT;
fi














# Alias
alias ls='ls --color=auto'
alias wgetr='wget -r -np -R "index.html*"'
alias ydla='youtube-dl -o "%(title)s.%(ext)s" -f mp4 --extract-audio --write-thumbnail --write-description'
alias ydl4='youtube-dl -o "%(title)s.%(ext)s" -f mp4'
alias ydl='youtube-dl -o "%(title)s.%(ext)s"'
alias m='mpv'
alias ctl='supervisorctl'
alias userctl='systemctl --user'
alias reload='sudo killall -SIGUSR1'
alias dns='sudo killall -SIGHUP mDNSResponder'

alias hz="cfcli -d maomihz.com"
alias x00="cfcli -d x00.me"
alias ss8="cfcli -d ss8.pw"
alias lk1="cfcli -d lk1.bid"
alias ym="cfcli -d yumei.li"
alias cssa="cfcli -d cssatamu.com"
alias cf="cfcli"
alias cfd="cfcli -d"







# Functions
function rand() {
    CHAR="${1:-0-9a-z}"
    LEN="${2:-15}"
    cat /dev/urandom | base64 | tr -dc "$CHAR" | head -c "$LEN" | xargs
}

function rands() {
    CHAR="${1:-0-9a-z}"
    LEN="${2:-15}"
    cat /dev/urandom | tr -dc "$CHAR" | head -c "$LEN" | xargs
}

function rn() {
    rand "0-9" $*
}

function rc() {
    rand "0-9a-zA-Z" $*
}

function rl() {
    rand "a-z" $*
}

function rp() {
    rands '0-9A-Za-z!@#$%^&*()-+=' $*
}


function synctime() {
    date -s "$(curl -s --head http://google.com | grep ^Date: | sed 's/Date: //g')"
}


export AUR_PAGER=echo

function signdb() {
    DB=cat
    if [ -f "$DB.db.tar.gz" ]
    then
        gpg -bs --yes "$DB.db.tar.gz"
        gpg -bs --yes "$DB.files.tar.gz"
        gpg --verify "$DB.db.tar.gz.sig"
    fi
}
