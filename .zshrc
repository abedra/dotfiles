source ~/.zsh/bindkeys.zsh
source ~/.zsh/exports.zsh
source ~/.zsh/setopt.zsh
source ~/.zsh/functions.zsh
source ~/.zsh/history.zsh
source ~/.zsh/prompt.zsh
source ~/.zsh/completion.zsh
source ~/.zsh/zsh_hooks.zsh
source ~/.zsh/command_coloring.zsh

[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm
calPATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
