source ~/.zsh/colors.zsh
source ~/.zsh/bindkeys.zsh
source ~/.zsh/exports.zsh
source ~/.zsh/setopt.zsh
source ~/.zsh/functions.zsh
source ~/.zsh/history.zsh
source ~/.zsh/prompt.zsh
source ~/.zsh/completion.zsh
source ~/.zsh/zsh_hooks.zsh
source ~/.zsh/command_coloring.zsh

# OPAM configuration
. /Users/abedra/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
