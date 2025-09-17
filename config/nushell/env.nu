# env.nu
#
# Installed by:
# version = "0.107.0"
#
# Previously, environment variables were typically configured in `env.nu`.
# In general, most configuration can and should be performed in `config.nu`
# or one of the autoload directories.
#
# This file is generated for backwards compatibility for now.
# It is loaded before config.nu and login.nu
#
# See https://www.nushell.sh/book/configuration.html
#
# Also see `help config env` for more options.
#
# You can remove these comments if you want or leave
# them for future reference.

$env.config.show_banner = false

$env.PROMPT_COMMAND = {||
    let current_dir = (pwd | path expand)
    let username = (whoami | str trim)
    let hostname = (hostname | str trim)
    let datetime = (date now | format date "%H:%M:%S")

    let line1 = $"(ansi white)Nu(ansi reset) (ansi blue)($datetime)(ansi reset) (ansi white)($username)@($hostname)(ansi reset) (ansi "#61d6d6")($current_dir)(ansi reset)"
    # Second line of the prompt (e.g., a simple indicator for input)
    let line2 = ""
    # Combine them with a newline
    $"($line1)\n($line2)"
}
$env.PROMPT_COMMAND_RIGHT = {||}
$env.PROMPT_INDICATOR = $"(ansi "#16c60c")→(ansi reset) "
$env.render_right_prompt_on_last_line = false
