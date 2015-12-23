export CDPATH=.:~/src:~/src/personal:~/src/opensource:~/src/configs:~/src/groupon:~/src/eligible:~/Documents

export TERM=xterm-256color
#export LSCOLORS=gxfxcxdxbxegedabagacad
export CLICOLOR=1
#export GREP_OPTIONS='--color=auto'
export GREP_COLOR='3;33'
export PAGER=most
export EDITOR="emacs -nw"

if [[ $(uname) == 'Darwin' ]]; then
    export JAVA_HOME=`/usr/libexec/java_home`
fi

export GOPATH=~/src/golang
export PATH=/usr/local/bin:/usr/local/sbin:~/.cabal/bin:$GOPATH/bin:$PATH
