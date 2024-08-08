autoload -Uz compinit
compinit
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt autocd
alias ls="ls --color=auto"
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export PATH=~/.local/bin:/usr/local/bin:$PATH
export CDPATH=.:~/src:~/src/configs:~/src/opensource:~/src/personal
source $HOME/.localrc
[ -s "$HOME/.scm_breeze/scm_breeze.sh" ] && source "$HOME/.scm_breeze/scm_breeze.sh"
eval "$(starship init zsh)"
