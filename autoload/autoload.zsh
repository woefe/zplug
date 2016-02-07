#!/bin/zsh

__import "core/core"
__import "job/polling"

local    cmd
local -a autoload_dirs autoload_files

__get_autoload_dirs;  autoload_dirs=(  "${reply[@]}" )
__get_autoload_files; autoload_files=( "${reply[@]}" )

if (( $+functions[${autoload_files[$(($RANDOM % $#autoload_files + 1))]}] )); then
    return 0
fi

fpath=(
"${autoload_dirs[@]}"
$fpath
)

for cmd in "${autoload_files[@]}"
do
    autoload -Uz "$cmd"
done

# Load external file
if [[ -f $ZPLUG_EXTERNAL ]]; then
    source "$ZPLUG_EXTERNAL"
fi
