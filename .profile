# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# Default programs to run
export EDITOR="vim"

# Colorized less and man cmd {{{1
export LESS=-R
export LESS_TERMCAP_mb="$(printf '%b' '[1;31m')"; a="${a%_}"
export LESS_TERMCAP_md="$(printf '%b' '[1;36m')"; a="${a%_}"
export LESS_TERMCAP_me="$(printf '%b' '[0m')"; a="${a%_}"
export LESS_TERMCAP_so="$(printf '%b' '[01;44;33m')"; a="${a%_}"
export LESS_TERMCAP_se="$(printf '%b' '[0m')"; a="${a%_}"
export LESS_TERMCAP_us="$(printf '%b' '[1;32m')"; a="${a%_}"
export LESS_TERMCAP_ue="$(printf '%b' '[0m')"; a="${a%_}"
# }}}1

# Emulator specific {{1
# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi
# }}}1

# WSL1/2 specific {{{1
# WSL2
if grep -q "microsoft" /proc/version &>/dev/null; then
    # Requires: https://sourceforge.net/projects/vcxsrv/ (or alternatives)
    export DISPLAY="$(/sbin/ip route | awk '/default/ { print $3 }'):0"
    export GPG_TTY=$(tty)
fi
# WSL1
if grep -qE "(Microsoft|WSL)" /proc/version &>/dev/null; then
    if [ "$(umask)" = "0000" ]; then
        umask 0022
    fi
    # Requires: https://sourceforge.net/projects/vcxsrv/ (or alternatives)
    export DISPLAY=:0
fi
# Podman (config without SYSTEMD)
if [[ -z "$XDG_RUNTIME_DIR" ]]; then
    export XDG_RUNTIME_DIR=/run/user/$UID
    if [[ ! -d "$XDG_RUNTIME_DIR" ]]; then
        export XDG_RUNTIME_DIR=/tmp/$USER-runtime
        if [[ ! -d "$XDG_RUNTIME_DIR" ]]; then
        mkdir -m 0700 "$XDG_RUNTIME_DIR"
        fi
    fi
fi
# Add wslinks (to simulate windows binaries as native ones)
if [ -d "$HOME/bin/wslinks" ] ; then
    PATH="$HOME/bin/wslinks:$PATH"
fi
# }}}1

# CLI programs {{{1
# CLI - fzf {{{2
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"
export FZF_DEFAULT_OPTS=" \
    --multi \
    --border=none \
    --margin=2,3% \
    --padding=2,3% \
    --pointer='>' \
    --marker='>' \
    --preview ' \
        if [ -f {} ]; then \
            bat --color=always --style=header,rule,numbers --line-range=:500 {}; \
        elif [ -d {} ]; then \
            tree -C {}; \
        fi' \
    --preview-window=right
    "
# }}}2
# CLI - vagrant
export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS="1"
export PATH="$PATH:/c/Program Files/Oracle/VirtualBox"
# }}}2
# CLI - bat

# }}}2
# }}}1
