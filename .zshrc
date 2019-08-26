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

PATH="/Users/abedra/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/Users/abedra/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/Users/abedra/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/Users/abedra/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/abedra/perl5"; export PERL_MM_OPT;

[ -s "/home/abedra/.scm_breeze/scm_breeze.sh" ] && source "/home/abedra/.scm_breeze/scm_breeze.sh"
