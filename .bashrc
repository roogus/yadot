# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

# Session/Prompt Settings
GPG_TTY=$(tty)
export GPG_TTY="${GPG_TTY}"
if [ "$SESSION_TYPE" == "remote/ssh" ] ; then
	export PS1="\[\033[1;33m\][ssh] \[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] λ:> "
        export PINENTRY_USER_DATA="USE_CURSES=1"
else
	export PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] λ:> "
fi

PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'

if [ -x /usr/bin/gpg-agent ]; then
    socket="$(gpgconf --list-dirs agent-ssh-socket)"
    export SSH_AUTH_SOCK="${socket}"
    gpgconf --launch gpg-agent
fi

# Go Settings
if [ ! -d "${HOME}/src/go" ] ; then
    mkdir -p "${HOME}/src/go/"{bin,pkg,src}
fi
GOPATH="${HOME}/src/go"
GOBIN="${GOPATH}/bin"
export GOPATH="${GOPATH}"
export GOBIN="${GOBIN}"


# .NET Settings
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export DOTNET_ROOT="/opt/dotnet-sdk-bin-6.0"
MSBuildSDKsPath="$DOTNET_ROOT/sdk/$(${DOTNET_ROOT}/dotnet --version)/Sdks"
export MSBuildSDKsPath

# General Settings
fzf_theme_path="${XDG_CONFIG_HOME}/fzf/base16-fzf/bash/base16-irblack.config"
BASE16_SHELL="${XDG_CONFIG_HOME}/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "${BASE16_SHELL}/profile_helper.sh" ] && \
        eval "$("${BASE16_SHELL}/profile_helper.sh")"
export EDITOR="nvim"
export VISUAL="nvim"
export GIT_EDITOR="nvim"
export FZF_DEFAULT_OPTS="--prompt=' ' --marker='+' --pointer='ﰲ' --no-info"
source "${fzf_theme_path}"
#export PAGER="/usr/bin/nvim -R"
export PATH="${PATH}:${GOBIN}:~/.cargo/bin:~/.local/bin:${DOTNET_ROOT}"
export BAT_THEME="base16-256"
export LC_COLLATE="C"


# NNN Settings
export SPLIT='v'
export USE_PISTOL=1
NNN_PIPE_PATH="${TMP}/nnn.fifo"
if [ -p "${NNN_PIPE_PATH}" ] ; then
    NNN_FIFO="${NNN_PIPE_PATH}"
    export NNN_FIFO
else
    NNN_FIFO=$(mkfifo "${NNN_PIPE_PATH}")
    export NNN_FIFO
fi

NNN_PREVIEW_PATH="${XDG_CACHE_HOME}/nnn/previews"
if [ ! -d "${NNN_PREVIEW_PATH}" ] ; then
    mkdir -p "${NNN_PREVIEW_PATH}"
fi
NNN_PREVIEWDIR="${NNN_PREVIEW_PATH}"
export NNN_PREVIEWDIR

export NNN_PLUG='o:fzopen;h:fzhist;v:imgview;p:preview-tui'

# General Alias'
alias mvi='mpv --config-dir=$HOME/.config/mvi'
alias ls='exa --icons'
alias luamake=/home/roogus/src/lua-language-server/3rd/luamake/luamake
alias nnn='nnn -e -H'
