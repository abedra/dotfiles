export CDPATH=.:~/src:~/src/personal:~/src/opensource:~/src/configs:~/src/jemurai:~/src/clients

export TERM=xterm-256color
export CLICOLOR=1
export GREP_COLOR='3;33'
export PAGER=most
export EDITOR="/usr/local/bin/emacs"

if [[ $(uname) == 'Darwin' ]]; then
    export JAVA_HOME=`/usr/libexec/java_home`
    export C_INCLUDE_PATH=/usr/local/include
    export CPLUS_INCLUDE_PATH=/usr/local/include
    export LIBRARY_PATH=/usr/local/lib
fi

export GOPATH=~/src/golang
export PATH=/usr/local/bin:/usr/local/sbin:~/.cabal/bin:$GOPATH/bin:$PATH
