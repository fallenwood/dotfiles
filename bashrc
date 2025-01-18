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


test -f "$OSH/oh-my-bash.sh" && source $OSH/oh-my-bash.sh
if command -v _omb_util_add_prompt_command &> /dev/null; then
_omb_util_add_prompt_command custom_prompt_command
fi

source $HOME/.dotfiles/customrc



# >>> xmake >>>
test -f "/home/vbox/.xmake/profile" && source "/home/vbox/.xmake/profile"
# <<< xmake <<<


if [[ -z "$BASH_INITIALIZED" ]]; then
  export BASH_INITIALIZED=1
  # exec fish
fi

        if [[ -n "${EXEC_FISH_ONCE}" ]]; then
            unset EXEC_FISH_ONCE
            exec fish
        fi
