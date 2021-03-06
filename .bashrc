# "merge" history from all active terms
export HISTFILESIZE=1000000000
export HISTSIZE=1000000

PROMPT_COMMAND=

# "merge" history from all active terms
export PROMPT_COMMAND='history -a' # equivalent to shopt -s histappend ?

# change color prompt given exit code from the last command
#     format: user@hostname:current_pwd$
#             +------------+-----------+
#     color:  + usercolor  + green/red +
export PS1='\[\033['${!USER}'m\]\[\033[1m\]\u@\h:`if [[ $? = 0 ]]; then echo \[\033[32m\]; else echo \[\033[31m\]; fi`\w$\[\033[0m\] '

#### PROMPT colors and text
function setUserColor {
    if [ -z "${!USER}" ] ; then
        local USER_HASH
        USER_HASH=$(echo $USER | md5sum | cut -f1 -d' ')
        local USER_NID
        USER_NID=$(echo "obase=10; ibase=16; ${USER_HASH}" | bc)
        export "${USER}"="$(( USER_NID % 6 + 93 ))" # one color per user (up to 8 colors)
    fi
}

export PROMPT_COMMAND="setUserColor ; ${PROMPT_COMMAND}" # merge history of all the terminals

function historyHistogram {
    history|awk '{print $2}'|awk 'BEGIN {FS="|"} {print $1}'|sort|uniq -c|sort -nr
}

#### Terminal title
function printTermTitle {
    if [ -z "${TERM_TITLE}" ] ; then
        TITLE="$(basename "${PWD}")"
    else
        TITLE="${TERM_TITLE}"
    fi

    echo -ne "\033]0; ${TITLE} \007"
}

function setTermTitle {
    #if [ "${USER}" != "$(stat -c "%U" ~/.bashrc)" ] ; then
    #fi

    export TERM_TITLE="$*"
}

setTermTitle  # term title will be current basedir (at anytime).
export PROMPT_COMMAND="printTermTitle ; ${PROMPT_COMMAND}" # set term title

#### history
export PROMPT_COMMAND="history -a ; ${PROMPT_COMMAND}" # merge history of all the terminals
#setTermTitle "$(pwd -P | xargs basename)"  # term title will be current basedir (at term creation)

#### misc
export PATH=${PATH}:~/.local/bin # for python modules installed from pip3

export LESS=-R
alias open='xdg-open'
