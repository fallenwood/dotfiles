# OSH
export OSH=$HOME/.oh-my-bash

function custom_prompt_command() {
    THEME_CLOCK_FORMAT=${THEME_CLOCK_FORMAT:-"%H:%M:%S"}
    # This needs to be first to save last command return code
    local RC="$?"

    local hostname="${_omb_prompt_bold_gray}\u@\h"
    local python_venv; _omb_prompt_get_python_venv
    python_venv=$_omb_prompt_white$python_venv

    # Set return status color
    if [[ ${RC} == 0 ]]; then
        ret_status="${_omb_prompt_bold_green}"
    else
        ret_status="${_omb_prompt_bold_brown}"
    fi

    # Append new history lines to history file
    history -a    
    PS1="$(clock_prompt)$python_venv ${hostname} ${_omb_prompt_bold_teal}\W $(scm_prompt_char_info)${ret_status}
→ ${_omb_prompt_normal}"
}

OSH_THEME="font"

completions=(
  git
  ssh
)

aliases=(
  general
)

plugins=(
  git
  bashmarks
)


source $OSH/oh-my-bash.sh
_omb_util_add_prompt_command custom_prompt_command

source $HOME/.dotfiles/customrc
