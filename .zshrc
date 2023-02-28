# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.local/share/fig/plugins/ohmyzsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting web-search)

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

function secondcolumn() { awk '{print $2}'; }
alias dev='kubectl config get-contexts | grep development | secondcolumn | xargs kubectl config use-context'
alias prod="kubectl config get-contexts | grep prod | secondcolumn | xargs kubectl config use-context"
alias mt="kubectl config get-contexts | grep machine-translation | secondcolumn | xargs kubectl config use-context"
alias turn_on_model='f() {
curl https://model-switch-mt.lengoo-internal.de/turn_on\?model\=$1\&correlation_id\=crr_ID | json_pp -json_opt pretty,canonical
};f'
alias list_models='f(){
curl https://model-api-mt.lengoo-internal.de/models | json_pp -json_opt pretty,canonical
};f'
