# "merge" history from all active terms
export PROMPT_COMMAND='history -a'

# change color prompt given exit code from the last command
export PS1='`if [[ $? = 0 ]]; then echo \[\033[32m\]; else echo \[\033[31m\]; fi`\[\033[1m\]\u@\h:\[\033[94m\]\w$\[\033[0m\] '

setTermTitle() {
    TITLE="$*"
    PROMPT_COMMAND='echo -ne "\033]0; ${TITLE} \007"'
}

setTermTitle "$(pwd -P | xargs basename)"

export LESS=-R
