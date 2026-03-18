# User Custom ~/.zshrc

# Colors
# black, white, yellow, green, red, blue, cyan, magenta
# Usage: '%F{cyan}Test%f'

# CLI and LS Colors
# https://www.cyberciti.biz/faq/apple-mac-osx-terminal-color-ls-output-option/
# Attribute	F B       # Color Codes
# --------- - -       # - ---------
# directory	e	x       # a	Black
# symbolic	f	x       # b	Red
# socket    c	x       # c	Green
# pipe	    d	x       # d	Brown
# exec	    b	x       # e	Blue
# block	    e	g       # f	Magenta
# char	    e	d
# exec	    a	b
# exec	    a	g
# directory	a	c
# directory	a	d
export CLICOLOR=1
export LSCOLORS=gxfxcxdxbxegedabagaced
# export LSCOLORS=exfxcxdxbxegedabagacad # Original

## History
# https://www.soberkoder.com/better-zsh-history/
# https://jdhao.github.io/2021/03/24/zsh_history_setup/
export HISTFILE=~/.zsh_history
export HISTFILESIZE=1000000
export HISTSIZE=10000000
export HISTTIMEFORMAT="[%F %T] "
# HISTSIZE=10000000
# SAVEHIST=1000000

# INC_APPEND_HISTORY: Immediate append Setting option ensures that commands are
# added to the history immediately (otherwise, this would happen only when the
# shell exits, and you could lose history upon unexpected/unclean termination 
# of the shell).
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_FIND_NO_DUPS
# setopt HIST_IGNORE_ALL_DUPS

[ -n "$ZSH_VERSION" ] && MY_SRC="$HOME/.zshrc" || MY_SRC="$HOME/.bashrc"
if [ -n "$ZSH_VERSION" ]; then
    $( python --version &> /dev/null );[ 0 -eq "$?" ] && export PY='python' || export PY='python3'
else
    [ -n $(which python) ] && export PY="$( which python | awk '{print $NF}' )"
    [ -n $(which python3) ] && export PY="$( which python3 | awk '{print $NF}' )"
fi

## Aliases
alias cls=clear
alias cs='pycodestyle --ignore=E121,E123,E126,E133,E226,E501,E704,W503,W504'
alias diff='diff --color=auto'
alias egrep='egrep --color=auto'
alias get-path="echo $PATH | tr ':' '\n'"
alias grep='grep --color=auto'
alias hs='fc -l -i -20 -1'
alias hss='fc -l -i -10000 -1 | grep -E '
alias la='ls -laG'
alias lb='ls -la /etc/bashrc* && ls -la /etc/zshrc*'
alias ll='ls -lG'
alias ls='ls -G'
alias md='mkdir'
alias py="$PY"
[ 'python' != "$PY" ] && alias python="$PY"
alias tree='pwd;tree'
alias ptree="pwd;tree -I '__pycache__|cache|css|doc|fa-*|fonts|images|js|node_module|vendors|venv'"

[ -n "$ZSH_VERSION" ] && alias sb='exec zsh'
[ -z "$ZSH_VERSION" ] && alias sb='exec bash'

## AWS
alias cfn-lint='cfn-lint -f pretty'
alias lm='list-max-size'
alias le='list-file-ext'
alias ccat='pygmentize -g -O style=monokai'
alias ccatl='pygmentize -g -O style=monokai,linenos=1'

## Venv
alias cdalias="alias | grep '^alias cd'" 
alias cdapi="cd $HOME/www/api;pwd"
alias cdaws="cd $HOME/www/aws.org/src;pwd"
alias cdjs="cd $HOME/www/WSO/JavaScript;pwd"
alias cdmo="cd '$HOME/Documents/Admin-PC-2019/My Web Projects/Molana/httpdocs';pwd"
alias cdmolana="cd '$HOME/Documents/Admin-PC-2019/My Web Projects/Molana/httpdocs';pwd"
alias cdorg="cd $HOME/www/aws.org/src;pwd"
alias cdwso="cd $HOME/www/WSO/JavaScript;pwd"
alias cdwww="cd $HOME/www;pwd"
alias wsoup="cd $HOME/www/WSO/JavaScript;php -S localhost:8000"
alias kill8000='pid=$(lsof -i :8000 | tail -1 | awk "{print \$2}"); [ -n "$pid" ] && kill -9 $pid'

function killport() {
    local port=$1
    lsof -i :$port
    qa "Do you want to kill process on port $port?"
    [ 0 -ne "$?" ] && return
    local pid=$(lsof -i :$port | tail -1 | awk '{print $2}')
    [ -n "$pid" ] && kill -9 $pid && echo "Killed process $pid on port $port" || echo "No process found on port $port"
}

alias vset='[[ "$(basename "$(pwd)")" == "src" ]] && source ../venv/bin/activate || source venv/bin/activate'
alias vunset='deactivate'
alias vstat='pip -V'

# Tools
alias compound-interest='/Users/bamdad/www/WSO/src/bin/calculate_compound_interest.py'
alias tax-bracket='/Users/bamdad/www/WSO/src/bin/tax-bracket.py'

function omp() {
    # usage: Oh My Posh. A prompt theme engine for any shell ###
    local font='meslo-lg'
    local rep=$(printf -- '-%0.s' {1..80})
    local title="Oh My Posh Font List & Installation"
    local which_shell
    [ -z "$ZSH_VERSION" ] && which_shell="bash" || which_shell="zsh"
    echo "$title ${rep:${#title}}"
    brew search nerd-font
    echo
    echo "https://ohmyposh.dev/docs/installation/fonts"
    echo "$rep"
    echo "brew install --cask <font>"
    echo "eval '\$(oh-my-posh init $which_shell --config ~/config.omp.json)'"
    echo
    echo "Usage:"
}

function ompf() {
    # usage: installs Oh My Posh front from $1 ###
    # https://ohmyposh.dev/
    [ -z "$1" ] && echo "Missing required argument font. Ex. omp meslo-lg" && return
    local font="$1"
    [ "$1" = "netron" ] && $(brew install --cask "${font}") && return
    $(brew install --cask "font-${font}-nerd-font")
}

## Extended Commands
function cl() {
    # usage: ... | cl # counts lines from stdin ###
    local count=0
    local line
    while read -r line; do count=$(( count + 1 )); done
    echo $count
}

function line() {
    # usage: ... | line $1 # returns line number $1 if exist from stdin ###
    local i=0
    local lineno="$1"
    while read -r line; do 
        i=$((i+1))
        [ "$i" -eq "$lineno" ] && echo -e "$line" && break
    done
}

function exe() {
    # usage: exe command [arg] [kwargs] # adds metadata to shell command ###
    local cmd="$*"  # Get the command from the argument
    local output=$(eval "$cmd")  # Execute the command and capture its output
    local exitCode="$?"  # Capture the exit code of the command
    local lineCount=$(echo "$output" | wc -l | awk '{print $1}')  # Count the number of lines in the output
    [ $exitCode -eq 0 ] && exitText="${Green}${exitCode} Success${NC}" || exitText="${Red}${exitCode} Failed!${NC}"  # Display the exit code

    # Display the output to stderr so it doesn't interfere with the command's stdout
    echo -e "${output}" >&2
    wline >&2
    echo -e "Command  : ${iYellow}${cmd}${NC}" >&2
    echo -e "Date     : $(date)" >&2
    echo -e "ExitCode : ${exitText}" >&2
    echo -e "LineCount: ${iYellow}${lineCount}${NC}" >&2

    if [ $exitCode -ne 0 ]; then
        echo >&2
        echo "Showing top 10 lines of the output with ExitCode: ${exitCode}" >&2
        wline >&2
        echo -e "$output" | head -n 10 >&2
    fi
}

function calc() {
    # usage: calc "$*" # returns python calculation ###
    "$PY" -c "print($@)"
}

function fmt_float() {
    # usage: fmt_float number digits # returns float number if digits given and greather than zero ###
    local float digits
    float="$1"
    [ -z "$2" ] && digits=0 || digits="$2"
    "$PY" -c "digits = $digits;print( float(format($float, f'.{digits}f')) if digits > 0 else int($float) )"
}

function func_lineno() {
    # usage: func_lineno funcname [offset] # returns line number of function ###
    local funcname offset lineno
    funcname="$1"
    offset="$2"
    lineno=$(grep -n "^function ${funcname}()" $MY_SRC | awk -F: '{print $1}')
    [ -z "$offset" ] && $lineno || echo $(( lineno + offset))
}

function list-home() {
    # usage: list-sys-file # lists system files in home directory ###
    local l file ftime
    local SYS_FILES=$(ls -1aF ~ | grep -Ev '\/|@|DS_Store')
    local i=0;
    col_width='%5s  %6s  %-20s  %s\n'
    for file in $SYS_FILES; do 
        ((i++));
        if [ "$i" -eq 1 ]; then
            printf "$col_width" "#" "Lines" "Last modification" "File"
            wline
        fi
        ftime=$( ls -laD '%Y-%m-%d %T' | grep " ${file}\$" | awk '{print $6, $7}' )
        l=$(cat $file | countl);
        color="$NORMAL"
        [ "${file:0:1}" = "." ] && color="$RED"
        [[ "${file}" =~ ".omp." ]] && color="$GREEN"
        printf "$col_width" "${i}." "$l" "$ftime" "${color}${file}${NORMAL}"
    done
    wline
    echo -e "Colors: ${Red}Hidden${NC}, ${Green}Oh My Posh${NC}, Others"
}

function round_down() {
    # usage: round_down number decimals # Rounds a number down to the given number of decimals ###
    [ -z "$2" ] && decimal=0 || decimal="$2"
    "$PY" -c "import math; factor = 10 ** $decimal;print(math.floor($1 * factor) / factor)"
}

function round_up() {
    # usage: round_down number decimals # Rounds a number down to the given number of decimals ###
    [ -z "$2" ] && decimal=0 || decimal="$2"
    "$PY" -c "import math; factor = 10 ** $decimal;print(math.ceil($1 * factor) / factor)"
}

function qa() {
    # usage: [prompt] # returns 0 if y or 1 for anything else ###
    [ -z "${1}" ] && prompt='Do you want to proceed?' || prompt="${1}"
    echo -en "${prompt} [y/n] "

    if [ -z "${ZSH_VERSION}" ]; then
        # Bash
        read -n1 -s answer
    else
        # ZSH
        read -k1 -s answer
    fi

    echo
    # Retun 0 for y and 1 for anything else
    [ 'y' = "$answer" ] && return 0 || return 1
}

function cx() {
    # usage: makes python & bash fiels executable ###
    local TYPES FILES TYPE i line answer
    echo -e "Current Path is ${Yellow}$(pwd)${NC}"

    TYPES='\.py$|\.sh$'
    PTYPES=$( echo $TYPES | tr -d '\\$')
    FILES=$(find . -type f | grep -E "${TYPES}")

    COLUMN='%5s  %-3s  %-4s  %-s\n'
    echo
    printf "${COLUMN}" "#" "Exe" "Type" "File Type [${YELLOW}${PTYPES}${NORMAL}]"
    wline
    i=0
    while read -r file; do
        i=$(( i + 1 ))
        TYPE=".$(echo $file | tr '.' ' ' | awk '{print $NF}')"
        if [ -x $file ]; then
            printf "${COLUMN}" "${i}." "${GREEN}+x${NORMAL}" "${TYPE}" "${file}"
        else
            GO=1
            printf "${COLUMN}" "${i}." "${RED}-x${NORMAL}" "${TYPE}" "${file}"
        fi
    done < <(printf '%s\n' "$FILES")
    wline

    [ -z "$GO" ] && echo -e "${Yellow}Skipped${NC}: Nothing to change for File Type [${iYellow}${PTYPES}${NC}]!" && return
    # read -n 1 -s -r -p "Do you want to chmod +x ${pycount} '*.py' and ${shCount} '*.sh' files? [y/n] " answer
    qa "Do you want to make above files executable?"
    answer="$?"
    
    if [ 0 -eq "$answer" ]; then
        echo
        echo -e "${Yellow}Executing${NC}: Recursive chmod +x '${Yellow}*.${TYPE}${NC}' Files"
        echo
        printf "${COLUMN}" "#" "Exe" "Type" "File Type [${YELLOW}${PTYPES}${NORMAL}]"
        wline
        i=0
        while read -r file; do
            i=$(( i + 1 ))
            [ ! -x $file ] && chmod +x "$file"

            TYPE=".$(echo $file | tr '.' ' ' | awk '{print $NF}')"
            if [ -x $file ]; then
                printf "${COLUMN}" "${i}." "${GREEN}+x${NORMAL}" "${TYPE}" "${file}"
            else
                printf "${COLUMN}" "${i}." "${RED}-x${NORMAL}" "${TYPE}" "${file}"
            fi
        done < <(printf '%s\n' "$FILES")
        wline
    else
        echo -e "${Red}Aborted${NC}: Nothing changed!"
    fi
}

function wcc() {
    # usage: use like wc # returns trimed leading spaces ###
    wc "$*" | sed 's/^ *//'
}

function count_file_lines() {
    # usage: count lines in file ###
    [ -n "$1" ] || [ -f "$1" ] && cat "$1" | wc -l | sed 's/^ *//'
}

function count_var_lines() {
    # usage: count lines in variable ###
    [ -n "$1" ] && echo -e "$1" | wc -l | sed 's/^ *//'
}

## Customization
[ -n "${BASH_SOURCE[0]}" ] && MY_SHELL="bash" || MY_SHELL="zsh"

function shebang() {
    # usage: [myPath] # returns shebang for shell or python ###
    [ 'bash' = "${MY_SHELL}" ] && iTrace "Line: $(func_lineno ${FUNCNAME[0]} 2), ${iYellow}${FUNCNAME[0]}()${NC} ${iCyan}${*}${NC}"
    [ 'zsh'  = "${MY_SHELL}" ] && iTrace "Line: $(( ${(%):-%I} - 3 )), ${iYellow}${funcstack[1]}()${NC} ${iCyan}${*}${NC}"
    local myPath TYPES i FILES COL sh
    [ -n "$1" ] && myPath="$1" || myPath="."
    TYPES='.py$|.sh$'

    i=0
    COL='%5s  %-25s  %-s\n'
    printf $COL "#" "Shebang" "File"
    wline
    while read -r FILE; do
        i=$(( i + 1 ))
        sh=$(cat $FILE |  head -1 )
        printf $COL "${i}." "${GREEN}${sh}${NORMAL}" "${BLUE}${FILE}${NORMAL}"
    done < <(find $myPath -type f | grep -E "${TYPES}")
    wline
    echo -e "Total: ${i}"
}

function shell-info() {
    # usage: [-a] # line input if no argument given or, an array of items with -a ###
    iTrace "Line: $(( ${(%):-%I} - 2 )), ${iYellow}${funcstack[1]}()${NC} ${iCyan}${*}${NC}"
    [ -n "$ZSH_VERSION" ] && pline "Shell" "$(zsh --version)"
    [ -z "$ZSH_VERSION" ] && pline "Shell" "$(bash --version | head -1)"
    [ -n "$(which aws)" ] && pline "AWS" "$(which -a aws | tail -1)"
    [ -n "$(which aws)" ] && pline "AWSVersion" "$($(which -a aws | tail -1) --version)"
    [ -n "$(which bash)" ] && pline "Bash" "$(which bash)"
    [ -n "$(which bash)" ] && pline "BashVesrion" "$(bash --version | head -1)"
    [ -n "$(which node)" ] && pline "Node" "$(which node)"
    [ -n "$(which node)" ] && pline "NodeVersion" "$(node --version)"
    [ -n "$(which pip)" ] && pline "PIP" "$(which -a pip | tail -1)"
    [ -n "$(which pip3)" ] && pline "PIP3" "$(which -a pip3 | tail -1)"
    [ -n "$(which python)" ] && pline "Python" "$(which python)"
    [ -n "$(which python)" ] && pline "PythonVeriosn" "$(python --version)"
    [ -n "$(which python3)" ] && pline "Python3" "$(which python3)"
    [ -n "$(which python3)" ] && pline "Python3Version" "$(python3 --version)"
    [ -n "$(which zsh)" ] && pline "ZSH" "$(which zsh)"
    [ -n "$(which zsh)" ] && pline "ZSHVersion" "$($(which zsh) --version)"
}

function shell-has() {
    # usage: [bash|zsh|bash-v|zsh-v|python|python3] # returns 1 or value ###
    iTrace "Line: $(( ${(%):-%I} - 2 )), ${iYellow}${funcstack[1]}()${NC} ${iCyan}${*}${NC}"
    local IFS lines line key i val 
    lines=$( shell-info )
    while IFS= read -r line; do
        key=$( echo "${line}" | tr '=' ' ' | awk '{print $1}' )
        i=$(( ${#key} + 1 ))
        val="${line:$i}"
        iTrace "$key : $val"
        if [ "$1" = "$key" ]; then
            iTrace "val: ${val:1:-1}"
            iTrace "sed: s/${key}: aliased to //"
            iTrace "out: $(echo "${val:1:-1}" | sed "s/${key}: aliased to //")"
            echo "${val:1:-1}" | sed "s/${key}: aliased to //"
            return
        fi
    done < <( printf '%s\n' "$lines" )
    which -a $1
    return
}

function shell-vars() {
    # usage: returns current BASH Variables ###
    iTrace "Line: $(( ${(%):-%I} - 2 )), ${iYellow}${funcstack[1]}()${NC} ${iCyan}${*}${NC}"
    # https://www.gnu.org/software/bash/manual/html_node/Bash-Variables.html
    # 
    local BASH_VARS EXCL_VARS VARS_CONT NULL_VARS MAX_LEN VAR i iStr
    BASH_VARS=( )
    EXCL_VARS=( )
    VARS_CONT=$(( BASH_VARS + EXCL_VARS ))
    NULL_VARS=()
    MAX_LEN=$(get_maxlen ${BASH_VARS[@]})
    echo -e "$(spc 5) $(jstr -w "$MAX_LEN" "BASH Variable Name")   Value of BASH Variable"
    wline
    i=0
    for VAR in ${BASH_VARS[@]}; do
        [[ -z "$ZSH_VERSION" && -z "${!VAR}" ]] && NULL_VARS+=( $VAR ) && continue      # Bash
        [[ -n "$ZSH_VERSION" && -z "${(P)VAR}" ]] && NULL_VARS+=( $VAR ) && continue    # Zsh
        i=$(( ++i ))
        iStr=$(jstr -w 4 -r "$i")
        echo -e "${iStr}. ${Blue}$(jstr -w $MAX_LEN ${VAR})${NC} : ${Green}${!VAR}${NC}"
    done
    wline
    echo -e "${i}/${VARS_CONT} BASH Variables with Value"
    echo
    echo -e "${#NULL_VARS[@]}/${VARS_CONT} BASH Variables without Value"
    wline
    echo -e "${Orange}${#NULL_VARS[@]}/${VARS_CONT}${NC}"
    echo
    echo -e "${#EXCL_VARS[@]}/${VARS_CONT} BASH Variables which Excluded"
    wline
    echo -e "${Gray}${EXCL_VARS}${NC}"
}

function env-info() {
    # usage: prints environment info  ###
    [ 'bash' = "${MY_SHELL}" ] && iTrace "Line: $(func_lineno ${FUNCNAME[0]} 2), ${iYellow}${FUNCNAME[0]}()${NC} ${iCyan}${*}${NC}" 
    [ 'zsh'  = "${MY_SHELL}" ] && iTrace "Line: $(( ${(%):-%I} - 3 )), ${iYellow}${funcstack[1]}()${NC} ${iCyan}${*}${NC}"
    local OS
    case $(echo "$OSTYPE" | tr '[:upper:]' '[:lower:]') in
        solaris*) OS="Solaris" ;;
        darwin*)  OS="OSX" ;;
        linux*)   OS="Linux" ;;
        bsd*)     OS="BSD" ;;
        msys*)    OS="Windows" ;;
        cygwin*)  OS="Windows" ;;
        *)        OS="unknown: $OSTYPE" ;;
    esac
    echo -e "${Blue}Main${NC}     : ${Green}${MY_SRC}${NC}"
    echo -e "${Blue}Platform${NC} : ${Green}$(uname -m), ${OS}, $(uname -o), Kernel Version $(uname -r)${NC}"
    echo -e "${Blue}Machine${NC}  : ${Green}$(echo $MACHTYPE)${NC}"
    echo -e "${Blue}Uptime${NC}   : ${Green}$(uptime)${NC}"
    echo -e "${Blue}Shell${NC}    : ${Green}${SHELL}${NC}"
    echo -e "${Blue}/bin/bash${NC}: ${Green}$( /bin/bash --version | head -1 )${NC}"
    [ -n "$(which bash)" ] && echo -e "${Blue}Bash${NC}     : ${Green}$( bash --version | head -1 )${NC}"
    [ -n "$(which zsh)" ] && echo -e "${Blue}Zsh${NC}      : ${Green}$( zsh --version )${NC}"
    echo -e "${Blue}AWS${NC}      : ${Green}$( aws --version | tr -d '\n' )${NC}"
    echo -e "${Blue}Python${NC}   : ${Green}$( $PY --version )${NC}"
    echo -e "${Blue}pip${NC}      : ${Green}$( pip --version | awk '{print $1, $2}' )${NC}"
    PIP=$(pip freeze)
    BOTO=$(echo -e "$PIP" | grep 'boto=' | tr '=' ' ' | awk '{print $2}')
    BOTO3=$(echo -e "$PIP" | grep 'boto3=' | tr '=' ' ' | awk '{print $2}')
    BOTOCORE=$(echo -e "$PIP" | grep 'botocore=' | tr '=' ' ' | awk '{print $2}')
    echo -e "${Blue}Boto${NC}     : ${Green}${BOTO}${NC}"
    echo -e "${Blue}Boto3${NC}    : ${Green}${BOTO3}${NC}"
    echo -e "${Blue}Botocore${NC} : ${Green}${BOTOCORE}${NC}"
    # Extend
    # https://github.com/coto/server-easy-install/blob/master/lib/core.sh#L15
}

function env-var() {
    ### usage: print filtered env vars ###
    [ 'bash' = "${MY_SHELL}" ] && iTrace "Line: $(func_lineno ${FUNCNAME[0]} 2), ${iYellow}${FUNCNAME[0]}()${NC} ${iCyan}${*}${NC}" 
    [ 'zsh'  = "${MY_SHELL}" ] && iTrace "Line: $(( ${(%):-%I} - 3 )), ${iYellow}${funcstack[1]}()${NC} ${iCyan}${*}${NC}"
    local FILT SECRET LEN LINE isSecret KEY VAL 
    FILT='HOME'
    SECRET='_KEY'
    LEN=$(env | grep -Ev "${FILT}" | wc -l | awk '{print $1}')
    iTrace "Total: ${LEN} Environment Variables with Filter: ${FILT}"

    i=0
    while read -r line; do
        i=$(( i + 1 ))
        iTrace "${i}. : ${line}"
        isSecret=$(echo $line | grep -E "$SECRET")
        KEY=$(echo $line | tr '=' ' ' | awk '{print $1}')
        VAL=$(echo $line | tr '=' ' ' | awk '{print $2}')
        if [ -n "$isSecret" ]; then
            VAL="${iRed}***SECRET***${NC}"
        else
            VAL="${iGreen}${VAL}${NC}"
        fi
        echo -e "$(jstr -w 3 -r $i). ${iBlue}${KEY}${NC}=${VAL}"
    done < <(env | grep -Ev "${FILT}" | sort)
}

function press_any_key() {
    # usage: prints 'Press any key to continue?' and wait for user response ###
    local str="Press any key to continue... "
    [ -n "$1" ] && str=$1
    if [ -z  "$ZSH_VERSION" ]; then
        read -n 1 -s -r -p "$str"
    else
        echo -n "${str}"; read -k1 -s; echo
    fi
}

## PEP8
function pep-ignore() {
    # usage: ignore pep8 errors and warnign - can be done by --global-config & local config
    # E121 - Fix a badly indented line.
    # E123 - Fix a badly indented line. May break by false positive error.
    # E126 - Fix over-indented line.
    # E133 - Fix indentation undistinguish from the next logical line.
    # E226 - Fix missing whitespace around operator.
    # E501 - Try to make lines fit within --max-line-length characters.
    # E704 - Fix multiple statements on one line def
    # W503 - Fix line break occurred before a binary operator
    # W504 - Fix unnecessary inline comments that don't add meaningful context
    # W690 - FIx various deprrecated code (via lib2to3)
    echo -n 'E121,E123,E126,E133,E501,E704,W503,W504,W690'
}

function pep() {
    # usage: pep <.py file> [--in-place] ###
    local res
    [ -n "$2" ] && autopep8 --ignore $(pep-ignore) $@ && return ## autopep inplace
    res=$(autopep8 --ignore $(pep-ignore) --diff "$1")          ## autopep diff

    while read -r line; do
        color="$iGray"
        [ '@@' = "${line:0:2}" ] && color="$Yellow" 
        [ '-' = "${line:0:1}" ] && color="$Red" 
        [ '+' = "${line:0:1}" ] && color="$Green" 
        echo -e "${color}${line}${NC}"
    done < <(printf '%s\n' "$res")
}

function pep-fix() {
    # usage: .py file ###
    autopep8 --ignore $(pep-ignore) --in-place "$1"
}

function pep-list() {
    # usage: lists PEP8 code and fixes description ###
    local ignore list fix_list line color
    ignore=$(pep-ignore | tr ',' '|')
    raw_list=$(autopep8 --list-fixes)

    # fix missing uunofficial PEP8
    list=''
    while read -r line; do
        [ 'E402' = "${line:0:4}" ] && line='E402 - Fix module level import not at top of file'
        [ 'W503' = "${line:0:4}" ] && line='W503 - Fix line break before binary operator'
        [ 'W504' = "${line:0:4}" ] && line='W504 - Fix line break after operator'
        [ 'W605' = "${line:0:4}" ] && line='W605 - Fix invalid escape sequence 'x'.'
        [ 'E' = "${line:0:1}" ] && color="$Red" || color="$Yellow" 
        line="${color}$(echo "${line:0:4}" )${NC}$(echo "${line:4}" )"
        [ -n "$line" ] && list="${list}${line}\n"
    done < <(printf '%s\n' "$raw_list")

    ppwide "Auto PEP8 List Fixes"
    echo -e "$list"

    ppwide "Auto PEP8 Ignore List"
    echo -e "$list" | grep -E "$ignore"
    wline
    echo -e "Auto PEP8 Ignore List: ${Red}$(pep-ignore)${NC}"
}

function pip-list() {
    # usage: list installed pip packages
    pip list
    wline
    echo -e "$( pip list | grep -v -E 'Package|---' | wc -l | awk '{print $1}' ) Pckages installed"
    iInfo "pip list --outdated"
}

function pipf() {
    # usage: filter pip freeze by csv, space or pipe ###
    local vsep vhigh filt pips lines matches
    # add version separator macth for grep
    vsep=( '~' '=' '<' '>' )
    iTrace "create version separator macth for grep"
    for ver in "${vsep[@]}"; do
        [ -z "$vhigh" ] && vhigh="${ver}.*" || vhigh="${vhigh}|${ver}.*"
        iTrace "${ver} : ${vhigh}"
    done

    filt="$*"
    filt=$(echo -e "${filt}" | tr ' ' '|' | tr ',' '|')
    pips=$(pip freeze)
    lines=$(echo -e "${pips}" | grep -c '^')
    matches=$(echo -e "${pips}" | grep -E "${filt}" | grep -c '^')

    iTrace "vsep : ${vsep[@]}"
    iTrace "vhigh: ${vhigh}"
    iTrace "filt : ${filt}"
    iTrace "mixed: ${filt}${vhigh}"

    echo -e "${pips}" | grep -E "${filt}" | grep -E "${filt}${vhigh}"
    wline
    echo -e "${matches}/${lines} items matches in pip for: ${filt}"
}

## Log Set & Reset
function jlog() { 
    # usage: [-h|-t|-d|-i|-w|-s|-e|-c|-o|-f|-b|-u] # [-h|--help] for help ###
    iTrace "Line: $(( ${(%):-%I} - 2 )), ${iYellow}${funcstack[1]}()${NC} ${iCyan}${*}${NC}"
    local LOG_DATE HAS_DATE
    if [[ 0 = $# ]] || [[ '-h' == *"$*"*  ]] || [[ '-help' == *"$*"*  ]]; then
        echo "Set, reset & report log configuration"
        wline
        echo "options:"
        echo "  -h  --help  show this help with Log Configuration and exit"
        echo "  -t          set LV to  0 & LOGLEVEL to 'TRACE'"
        echo "  -d          set LV to  1 & LOGLEVEL to 'DEBUG'"
        echo "  -i          set LV to 10 & LOGLEVEL to 'INFO'"
        echo "  -w          set LV to 20 & LOGLEVEL to 'WARNING'"
        echo "  -s          set LV to 30 & LOGLEVEL to 'SUCCESS'"
        echo "  -e          set LV to 40 & LOGLEVEL to 'ERROR'"
        echo "  -c          set LV to 50 & LOGLEVEL to 'CRITICAL'"
        echo "  -o          show LOGLEVEL"
        echo "  -f          full LOGLEVEL with dt"
        echo "  -b          brief LOGLEVEL without dt. default"
        echo "  -u          unset LOGLEVEL to default"
    fi
    while [ $# -gt 0 ]; do 
        case "$1" in
            -t) 
                export LOGLEVEL=TRACE;shift;; 
            -d) 
                export LOGLEVEL=DEBUG;shift;;
            -i) 
                export LOGLEVEL=INFO;shift;;
            -w) 
                export LOGLEVEL=WARNING;shift;;
            -s) 
                export LOGLEVEL=SUCCESS;shift;;
            -e) 
                export LOGLEVEL=ERROR;shift;;
            -c) 
                export LOGLEVEL=CRITICAL;shift;;
            -o) 
                echo $LOGLEVEL;shift;;
            -b) 
                unset LOG_DATE;shift;;
            -f) 
                export LOG_DATE=1;shift;;
            -u) 
                unset LOGLEVEL;shift;;
            *) 
                shift;;
        esac
    done
    ppwide "Log Configuration"
    echo -e  "${Blue}LV       ${NC}: ${Green}$LV${NC}"
    echo -e  "${Blue}LOGLEVEL ${NC}: ${Green}$LOGLEVEL${NC}"
    echo -e  "${Blue}LOG_DATE ${NC}: ${Green}$LOG_DATE${NC}"
    [ "1" = "$LOG_DATE" ] && HAS_DATE='with' || HAS_DATE='without'
    echo -e -n "${Blue}Description ${NC}: Log Level "
    [ 0 -eq "$LV" ] && echo -e -n "${Gray}${LV} ${LOGLEVEL}${NC} "
    [ 1 -eq "$LV" ] && echo -e -n "${Yellow}${LV} ${LOGLEVEL}${NC} "
    [[ 10 -eq "$LV" || 20 -eq "$LV" ]] && echo -e -n "${Green}${LV} ${LOGLEVEL}${NC} "
    [ 30 -eq "$LV" ] && echo -e -n "${Green}${LV} ${LOGLEVEL}${NC} "
    [[ 40 -eq "$LV" || 50 -eq "$LV" ]] && echo -e -n "${Red}${LV} ${LOGLEVEL}${NC} "
    echo -e "${HAS_DATE} datetime"
}

## Custom Functions
[ -n "$ZSH_VERSION" ] && autoload -Uz promptinit && promptinit
# $prompt_newline # to add new line in PS prompts

function set_colors() {
    # usage: Sets colors. Should be called ###
    # which shell
    # zsh colors: \e, bash colors: \033
    [ -n "$ZSH_VERSION" ] && Esc='\e' || Esc='\033' 

    # Color for printf
    BLACK=$(tput setaf 0)
    RED=$(tput setaf 1)
    GREEN=$(tput setaf 2)
    YELLOW=$(tput setaf 3)
    LIME_YELLOW=$(tput setaf 190)
    POWDER_BLUE=$(tput setaf 153)
    BLUE=$(tput setaf 4)
    MAGENTA=$(tput setaf 5)
    CYAN=$(tput setaf 6)
    WHITE=$(tput setaf 7)
    BRIGHT=$(tput bold)
    NORMAL=$(tput sgr0)
    BLINK=$(tput blink)
    REVERSE=$(tput smso)
    UNDERLINE=$(tput smul)

    # Reset
    NC="${Esc}[0;0m"

    # 0: Normal
    Normal="${Esc}[0m"
    Black="${Esc}[0;30m"      # Black
    Gray="${Esc}[0;90m"       # Gray
    Red="${Esc}[0;91m"        # Red
    Green="${Esc}[0;92m"      # Green
    Yellow="${Esc}[0;93m"     # Yellow
    Blue="${Esc}[0;94m"       # Blue
    Brown="${Esc}[38;5;94m"   # Brown
    Magenta="${Esc}[0;95m"    # Magenta
    Cyan="${Esc}[0;96m"       # Cyan
    Orange="${Esc}[38;5;166m" # Orange
    White="${Esc}[0;97m"      # White

    # 1: Bold
    BC="${Esc}[1m"
    bBlack="${Esc}[1;30m"   # Black
    bGray="${Esc}[1;90m"    # Gray
    bRed="${Esc}[1;91m"     # Red
    bGreen="${Esc}[1;92m"   # Green
    bYellow="${Esc}[1;93m"  # Yellow
    bBlue="${Esc}[1;94m"    # Blue
    bMagenta="${Esc}[1;95m" # Magenta
    bCyan="${Esc}[1;96m"    # Cyan
    bWhite="${Esc}[1;97m"   # White

    # 3: Italic
    IC="${Esc}[3m"
    iBlack="${Esc}[3;30m"   # Black
    iGray="${Esc}[3;90m"    # Gray
    iRed="${Esc}[3;91m"     # Red
    iGreen="${Esc}[3;92m"   # Green
    iYellow="${Esc}[3;93m"  # Yellow
    iBlue="${Esc}[3;94m"    # Blue
    iMagenta="${Esc}[3;95m" # Magenta
    iCyan="${Esc}[3;96m"    # Cyan
    iWhite="${Esc}[3;97m"   # White

    # 4: Underline
    UC="${Esc}[4m"
    uBlack="${Esc}[4;30m"   # Black
    uGray="${Esc}[4;90m"    # Gray
    uRed="${Esc}[4;91m"     # Red
    uGreen="${Esc}[4;92m"   # Green
    uYellow="${Esc}[4;93m"  # Yellow
    uBlue="${Esc}[4;94m"    # Blue
    uMagenta="${Esc}[4;95m" # Magenta
    uCyan="${Esc}[4;96m"    # Cyan
    uWhite="${Esc}[4;97m"   # White
}

set_colors

function list_colors() {
    # usage: list colors and styles ###
    echo 'Usage : echo -e "${Yellow}Yellow${NC} ${bYellow}bYellow${NC} ${iYellow}iYellow${NC} ${uYellow}uYellow${NC} Color Text"'
    echo -e "Ouput     : ${Yellow}Yellow${NC} ${bYellow}bYellow${NC} ${iYellow}iYellow${NC} ${uYellow}uYellow${NC} Color Text"
    wline
    echo 'NC Normal    :  Black Gray Red Green Yellow Blue Brown Magenta Cyan Orange White'
    echo 'BC Bold      :  bBlack bGray bRed bGreen bYellow bBlue bMagenta bCyan bWhite'
    echo 'IC Italic    :  iBlack iGray iRed iGreen iYellow iBlue iMagenta iCyan iWhite'
    echo 'UC Underline :  uBlack uGray uRed uGreen uYellow uBlue uMagenta uCyan uWhite'
    echo 'NC Reset     :  NC'
    echo 'Styles       :  NC BC IC UC'
}

function test_colors() {
    # usage: tunit test function for colors ###
    iTrace "Line: $(( ${(%):-%I} - 3 )), ${iYellow}${funcstack[1]}()${NC} ${iCyan}${*}${NC}"
    ppwide "Color Usage"
    list_colors
    ppwide "Color Demo"
    ppwide -b '-' "${NC}Normal Colors${NC}"
    echo -en " ${Black}Black${NC} "
    echo -en " ${Gray}Gray${NC} "
    echo -en " ${Red}Red${NC} "
    echo -en " ${Green}Green${NC} "
    echo -en " ${Yellow}Yellow${NC} "
    echo -en " ${Blue}Blue${NC} "
    echo -en " ${Brown}Brown${NC} "
    echo -en " ${Magenta}Magenta${NC} "
    echo -en " ${Cyan}Cyan${NC} "
    echo -en " ${Orange}Orange${NC} "
    echo -e " ${White}White${NC} "

    ppwide -b '-' "${BL}Bold Colors${NC}"
    echo -en "${bBlack}bBlack${NC} "
    echo -en "${bGray}bGray${NC} "
    echo -en "${bRed}bRed${NC} "
    echo -en "${bGreen}bGreen${NC} "
    echo -en "${bYellow}bYellow${NC} "
    echo -en "${bBlue}bBlue${NC} "
    echo -en "${bMagenta}bMagenta${NC} "
    echo -en "${bCyan}bCyan${NC} "
    echo -e "${bWhite}bWhite${NC} "

    ppwide -b '-' "${IC}Italic Colors${NC}"
    echo -en "${iBlack}iBlack${NC} "
    echo -en "${iGray}iGray${NC} "
    echo -en "${iRed}iRed${NC} "
    echo -en "${iGreen}iGreen${NC} "
    echo -en "${iYellow}iYellow${NC} "
    echo -en "${iBlue}iBlue${NC} "
    echo -en "${iMagenta}iMagenta${NC} "
    echo -en "${iCyan}iCyan${NC} "
    echo -e "${iWhite}iWhite${NC} "

    ppwide -b '-' "${UC}Underline Colors${NC}"
    echo -en "${uBlack}uBlack${NC} "
    echo -en "${uGray}uGray${NC} "
    echo -en "${uRed}uRed${NC} "
    echo -en "${uGreen}uGreen${NC} "
    echo -en "${uYellow}uYellow${NC} "
    echo -en "${uBlue}uBlue${NC} "
    echo -en "${uMagenta}uMagenta${NC} "
    echo -en "${uCyan}uCyan${NC} "
    echo -e "${uWhite}uWhite${NC} "
}

function ansi_colors() {
    # usage: unit test function for ansi colors ###
    iTrace "Line: $(( ${(%):-%I} - 2 )), ${iYellow}${funcstack[1]}()${NC} ${iCyan}${*}${NC}"
    noEsc="\\${Esc}"
    ppwide "ANSI Colors Demo / Escape code : ${Cyan}${noEsc}${NC}"

    for s in {0..4}; do
        ppwide -b '-' "Style: ${s}"
        for i in {30..48} {90..108}; do
            iStr=$( ndigits "$i" 3 )
            i_str="${noEsc}[${s};${i}m"; while [ ${#i_str} -lt 10 ]; do i_str="$i_str "; done
            [[ "$iStr" == *"9" ]] && continue
            echo -en "${Esc}[${s};${i}m${i_str}${NC} "
            [[ "$iStr" == *"8" ]] && echo
        done
    done
}

function 256_colors() {
    # usage: unit test function for 0-255 text forground colors ###
    iTrace "Line: $(( ${(%):-%I} - 2 )), ${iYellow}${funcstack[1]}()${NC} ${iCyan}${*}${NC}"
    # https://github.com/dylanaraps/pure-bash-bible#text-colors
    local noEsc i_str
    noEsc="\\${Esc}"
    ppwide "256 ANSI Colors / Escape code : ${Cyan}${noEsc}[${NC}"
    for i in {0..255}; do
        i_str="${i}m"; while [ ${#i_str} -lt 4 ]; do i_str="$i_str "; done
        echo -en "${Esc}[38;5;${i}m38;5;${i_str}${Esc}[0m  "
        [ 0 -eq $(( ++i % 8 )) ] && echo
    done
}

function list-docstr() {
    # usage: list-docstr: show a $function-name docstring ###
    local res filter line tab i name
    # grep -A 1 returns funtion & docsting, n is for numeric sort
    # grep -v removes -- separator
    # sed removes line number
    res=$(grep -nA 1 "^function .*${1}.*" $MY_SRC | sort -n | grep -v '^--$' | sed 's/^[0-9]*[-:]\s*//')
    [ -n "$1" ] && filter="filtered by ${Yellow}${1}${NC}"
    tab=$(spc 7)
    i=0
    while read -r line; do
    iTrace "line: $line"
        if [[ "${line}" == 'function'* ]]; then
            i=$(( i + 1))
            name=$( echo $line | tr -d '(){' | awk '{print $NF}')            
            printf "%5s. %-10s %-20s\n" "$i" "${BLUE}function${NORMAL}" "${YELLOW}${name}${NORMAL}"
        else
            printf "${tab}%s\n\n" "${GREEN}${line}${NORMAL}"
        fi
    done < <(printf '%s\n' "$res")
    wline
    echo -e "${i} Functions $filter"
    echo
    echo -e "usage: list-docstr [${Magenta}"function-name"${NC}] # filter by function name matching filter. e.x ${Blue}list-docstr${NC} ${Yellow}list-docstr${NC}"
}

function list-funcs() {
    # usage: list-funcs: show all functions filter by $1 in function name if given ###
    local res needle filter line tab i name
    [ -n "$*" ] && needle="$(echo "$*" | tr ' ' '|')"
    res=$(grep -EA 1 "^function .*(${needle}).*" $MY_SRC)
    [ -n "$1" ] && filter="filtered by ${Yellow}${needle}${NC}"
    tab=$(spc 5)
    i=0
    while read -r line; do
        if [ "${line:0:8}" = 'function' ]; then
            i=$(( i + 1))
            name=$( echo $line | tr -d '(){' | awk '{print $NF}')            
            printf "%3s. %-10s %-20s\n" "$i" "${BLUE}function${NORMAL}" "${YELLOW}${name}${NORMAL}"
        elif [ "${line:0:2}" = '--' ]; then
            echo
        else
            local color="$GREEN"
            echo "$line" | grep -Eq '#|###|,'
            [ 0 -ne $? ] && color="$RED"
            printf "${tab}%s\n" "${color}${line}${NORMAL}"
        fi
    done < <(printf '%s\n' "$res")
    wline
    echo -e "${i} Functions $filter"
    echo
    echo -e "usage: list-funcs [${Magenta}"filter1 filter2 ..."${NC}] # filters by function names matching filter. e.x. ${Blue}list-funcs${NC} ${Yellow}get list aws${NC}]"
}

function describe-funcs() {
    # usage: returns list of functions to review highlighted code, LoC, Start & End Line Numbers ###
    iTrace "Line: $(( ${(%):-%I} - 2 )), ${iYellow}${funcstack[1]}()${NC} ${iCyan}${*}${NC}"
    local h scope SCOPE FUNCS FFILT FUNC LINES GREP TOP BOT CNT TAIL HEAD LOC CODE PS3 HIST

    FFILT='add-zle|add-zsh|enable_posh|prompt|prompt_|shell_|set_poshcontext|update_terminal_cwd'
    scope='local'
    env-info
    for arg in "$@"; do
        [ '-h' = "$arg" ] && h=0
        [ '-a' = "$arg" ] && scope='all'
        [ '-l' = "$arg" ] && scope='local' # default
        [ '-s' = "$arg" ] && scope='sys'
        [ '--help' = "$arg" ] && h=0
        [ '--all' = "$arg" ] && scope='all'
        [ '--local' = "$arg" ] && scope='local'
        [ '--sys' = "$arg" ] && scope='sys'
    done

    if [ -n "$h" ]; then
        echo "List Function"
        wline 
        echo "args:"
        echo "  -h  --help   show this help and exit"
        echo "  -a  --all    list all functions"
        echo "  -l  --local  list local functions only, default local"
        echo "  -s  --sys    list system functions only"
        return
    fi

    declare -a FUNCS
    if [ 'sys' = "$scope" ]; then
        if [ "$MY_SHELL" = 'zsh' ]; then
            FUNCS=$( print -l ${(ok)functions} )
        else
            # shellcheck disable=SC1073,SC2207
            FUNCS=$( declare -F | awk '{print $3}' | grep '^_' )
        fi
    elif [ 'local' = "$scope" ]; then
        if [ "$MY_SHELL" = 'zsh' ]; then
            FUNCS=$( print -l ${(ok)functions} | grep -v '^_' )
        else
            # shellcheck disable=SC1073,SC2207
            FUNCS=$( declare -F | awk '{print $3}' | grep -v '^_' )
        fi
        # exclude sys funcs
        FUNCS=$( echo "$FUNCS" | grep -E -v  "$FFILT")
    elif [ 'all' = "$scope" ]; then
        if [ "$MY_SHELL" = 'zsh' ]; then
            FUNCS=$( print -l ${(ok)functions} )
        else
            # shellcheck disable=SC1073,SC2207
            FUNCS=$( declare -F | awk '{print $3}' )
        fi
    fi

    FUNCS=($( echo "Quit Clear ${FUNCS}" | tr '\n' ' ' ))
    CNT="${#FUNCS[@]}"
    CNT=$(( CNT - 2 ))
    SCOPE=$( title_case "${scope}" )
    iTrace "Quit + Functions (${CNT}) ${SCOPE}: ${FUNCS[@]}"

    declare -a HIST
    while [ 'Quit' != "$FUNC" ]; do
        echo "${CNT} ${SCOPE} Functions. 1) Quit, 2) Clear History, 3-${#FUNCS[@]}) Functions"
        wline
        local PS3="%{$fg[blue]%}Review History%{$reset_color%}: %{$fg[green]%}${HIST[@]}%{$reset_color%}${prompt_newline}%{$fg[yellow]%}Select%{$reset_color%} a function to see its %{$fg[yellow]%}code%{$reset_color%}. %{$fg[yellow]%}Select%{$reset_color%} %{$fg[red]%}1%{$reset_color%} to %{$fg[red]%}Quit%{$reset_color%} #? "
        select FUNC in "${FUNCS[@]}"; do
            case $FUNC in
                "$FUNC") break ;;
                *) exit ;;
            esac
        done

        # https://pygments.org/languages/
        # -l c++
        [ 'Clear' = "$FUNC" ] && HIST=() && iInfo "Cleaned up Review History!" && continue
        if [[ 'Quit' != "$FUNC" && -n "$FUNC" ]]; then
            i=0
            for iFunc in "${FUNCS[@]}"; do
                i=$(( i + 1 ))
                [ "$iFunc" = "$FUNC" ] && break
            done

            # New Code
            LINES=$( cat "$MY_SRC" | wc -l | sed 's/^ *//' )
            iDebug "LINES : $LINES"
            GREP="function ${FUNC}()"
            iDebug "GREP : $GREP"
            TOP=$( cat "$MY_SRC" | grep -n "${GREP}" | tr ':' ' ' | awk '{print $1}' )
            iDebug "TOP  : $TOP"
            BOT=0
            while read LINE; do
                BOT=$(( BOT + 1 ))
                [ "$BOT" -lt "$TOP" ] && continue
                [ '}' = "$LINE" ] && break 
            done < $MY_SRC
            iDebug "BOT  : $BOT"
            TAIL=$(( LINES - TOP + 1 ))
            HEAD=$(( BOT - TOP + 1 ))
            LOC="$HEAD"
            iDebug "TAIL : $TAIL"
            iDebug "HEAD  : $HEAD"
            CODE=$( cat "$MY_SRC" | tail -${TAIL} | head -${HEAD} )

            HIST+=( ${i}.${FUNC} )
            ppwide "Line ${Gray}#${TOP}-${BOT}${NC}, ${Gray}${LOC}${NC} LoC, #${i}. ${Cyan}function${NC} ${Yellow}${FUNC}${NC}()"
            pyg_out "$CODE"
            ppwide "Line ${Gray}#${TOP}-${BOT}${NC}, ${Gray}${LOC}${NC} LoC, #${i}. ${Cyan}function${NC} ${Yellow}${FUNC}${NC}()"
            echo -e "${Blue}Review History${NC}: ${Green}${HIST[@]}${NC}"
            press_any_key
            echo
        fi
    done
}

function list-file-ext() {
    # usage: use like ls to see extended ls -laf -D format report ###
    iTrace "Line: $(( ${(%):-%I} - 2 )), ${iYellow}${funcstack[1]}()${NC} ${iCyan}${*}${NC}"
    #    | grep -E 'EXE|DIR' # add at the end to filter for EXE & DIR only 
    #    | grep -E 'EXE|DIR|Perm|---|Total' # add at the end to filter for EXE & DIR with header 
    local FILES DAT_COUNT DIR_COUNT DOC_COUNT EXE_COUNT IMG_COUNT MISC_COUNT MAX_PERM 
    local MAX_LINKS MAX_OWNER MAX_GROUP MAX_SIZE LEN_PERM LEN_LINKS LEN_OWNER LEN_GROUP 
    local LEN_SIZE COLS_WIDTH LINE COLOR TYPE PERM LINKS OWNER GROUP SIZE DATE TIME 
    FILES=$( ls -laf -D '%Y-%m-%d %T' $* )

    DAT_COUNT=0
    DIR_COUNT=0
    DOC_COUNT=0
    EXE_COUNT=0
    IMG_COUNT=0
    MISC_COUNT=0

    # get columns max len
    COLS_HEAD=( Permissons Links Owner Group Size Date Time  Type File )

    MAX_PERM=${#COLS_HEAD[1]}
    MAX_LINKS=${#COLS_HEAD[2]}
    MAX_OWNER=${#COLS_HEAD[3]}
    MAX_GROUP=${#COLS_HEAD[4]}
    MAX_SIZE=${#COLS_HEAD[5]}

    while read -r LINE; do
        LEN_PERM=$( echo "$LINE" | awk '{print $1}' )
        LEN_LINKS=$( echo "$LINE" | awk '{print $2}' )
        LEN_OWNER=$( echo "$LINE" | awk '{print $3}' )
        LEN_GROUP=$( echo "$LINE" | awk '{print $4}' )
        LEN_SIZE=$( echo "$LINE" | awk '{print $5}' )

        [ "${#LEN_PERM}" -gt "${MAX_PERM}" ] && MAX_PERM="${#LEN_PERM}"
        [ "${#LEN_LINKS}" -gt "${MAX_LINKS}" ] && MAX_LINKS="${#LEN_LINKS}"
        [ "${#LEN_OWNER}" -gt "${MAX_OWNER}" ] && MAX_OWNER="${#LEN_OWNER}"
        [ "${#LEN_GROUP}" -gt "${MAX_GROUP}" ] && MAX_GROUP="${#LEN_GROUP}"
        [ "${#LEN_SIZE}" -gt "${MAX_SIZE}" ] && MAX_SIZE="${#LEN_SIZE}"

    done < <( printf '%s\n' "$FILES" | grep -Ev '^total|^$' )

    iDebug "COLS_HEAD : ${COLS_HEAD[*]}"
    iDebug "MAX_PERM  : $MAX_PERM"
    iDebug "MAX_LINKS : $MAX_LINKS"
    iDebug "MAX_OWNER : $MAX_OWNER"
    iDebug "MAX_GROUP : $MAX_GROUP"
    iDebug "MAX_SIZE  : $MAX_SIZE"
    COLS_WIDTH="%-${MAX_PERM}s  %${MAX_LINKS}s  %-${MAX_OWNER}s  %-${MAX_GROUP}s  %${MAX_SIZE}s  %-10s  %-8s  %-4s  %s\n" 

    iTrace "COLS_WIDTH : $COLS_WIDTH"
    iTrace "COLS_HEAD  : ${COLS_HEAD[*]}"
    # shellcheck disable=SC2059,SC2048
    printf "${COLS_WIDTH}" ${COLS_HEAD[*]}
    wline
    for TYPE in DIR DAT DOC EXE IMG MISC; do 
        i=0
        while read -r LINE; do
            i=$(( i + 1 ))

            FILE=$( echo "$LINE" | awk '{print $8}' )
            iTrace "FILE: ${FILE}"
            COLOR="${NORMAL}"

            if [ "$TYPE" = "DAT" ]; then
                [ 0 -eq "$( echo $LINE | grep -Eq '.csv$|.dat$|.json$|.tab$|.tml$|.toml$|.txt$|.yaml$|.yml$' ) $?" ] && COLOR="${LIME_YELLOW}" && DAT_COUNT=$(( DAT_COUNT + 1 )) || continue
            fi

            if [ "$TYPE" = "DIR" ]; then
                [ "${LINE:0:1}" = 'd' ] && COLOR="${CYAN}" && DIR_COUNT=$(( DIR_COUNT + 1 )) || continue
            fi

            if [ "$TYPE" = "DOC" ]; then
                [ 0 -eq "$( echo $LINE | grep -Eq '.md$' ) $?" ] && COLOR="${LIME_YELLOW}" && DOC_COUNT=$(( DOC_COUNT + 1 )) || continue
            fi

            if [ "$TYPE" = "EXE" ]; then
                [ 0 -eq "$( echo $LINE | grep -Eq '.py$|.sh$' ) $?" ] && COLOR="${RED}" && EXE_COUNT=$(( EXE_COUNT + 1 )) || continue
            fi

            if [ "$TYPE" = "IMG" ]; then
                [ 0 -eq "$( echo $LINE | grep -Eq '.jpeg$|.jpg$|.gif$|.png$|.bmp$' ) $?" ] && COLOR="${POWDER_BLUE}" && IMG_COUNT=$(( IMG_COUNT + 1 )) || continue
            fi

            if [ "$TYPE" = "MISC" ]; then
                [ "${LINE:0:1}" = 'd' ] && continue
                [ 0 -ne "$( echo $LINE | grep -Eq '.csv$|.dat$|.json$|.tab$|.tml$|.toml$|.yaml$|.yml$|.md$|.txt$|.py$|.sh$|.jpeg$|.jpg$|.gif$|.png$|.bmp$' ) $?" ] && COLOR="${NORMAL}" && MISC_COUNT=$(( MISC_COUNT + 1 )) || continue
            fi

            PERM=$( echo "$LINE" | awk '{print $1}' )
            LINKS=$( echo "$LINE" | awk '{print $2}' )
            OWNER=$( echo "$LINE" | awk '{print $3}' )
            GROUP=$( echo "$LINE" | awk '{print $4}' )
            SIZE=$( echo "$LINE" | awk '{print $5}' )
            DATE=$( echo "$LINE" | awk '{print $6}' )
            TIME=$( echo "$LINE" | awk '{print $7}' )

            printf "${COLS_WIDTH}" "${PERM}" "${LINKS}" "${OWNER}" "${GROUP}" "${SIZE}" "${DATE}" "${TIME}" "${COLOR}${TYPE}${NORMAL}" "${COLOR}${FILE}${NORMAL}"

        done < <( printf '%s\n' "$FILES" | grep -Ev '^total|^$' )
    done

    total=$( printf '%s\n' "$FILES" | grep -cv '^total|^$' )
    wline
    printf "${COLS_WIDTH}" ${COLS_HEAD[@]}
    wline
    printf '%s\n' "${total} Total, ${CYAN}$DIR_COUNT DIR${NORMAL}, ${LIME_YELLOW}$DAT_COUNT DAT${NORMAL}, $DOC_COUNT DOC, ${RED}$EXE_COUNT EXE${NORMAL}, ${POWDER_BLUE}$IMG_COUNT IMG${NORMAL}, $MISC_COUNT MISC"

    iTrace "COLS_WIDTH : $COLS_WIDTH"
}

function list-max-size() {
    # usage: [$1] # report for "$1" or current dir, from largest to smallest files ###
    iTrace "Line: $(( ${(%):-%I} - 2 )), ${iYellow}${funcstack[1]}()${NC} ${iCyan}${*}${NC}"
    local TITLE CUR_DIR SRC_DIR INPUT_DAT INPUT_CNT FST_FILE LST_FILE COLS_WIDTH 
    local IFS LINE SIZE FILE COLOR DATE TYPE LS_LINE
    TITLE='Max File Size Report'

    CUR_DIR=$( pwd )
    SRC_DIR="$1"
    [ -z "$SRC_DIR" ] && SRC_DIR="$CUR_DIR"

    # switch to desired dir
    cd "$SRC_DIR" || exit 1
    INPUT_DAT=$( ls -lv | awk '{print $9}' | grep -v '^$' ) 
    INPUT_CNT=$( echo -e "$INPUT_DAT" | wc -l | awk '{print $1}' )

    FST_FILE=$( echo -e "$INPUT_DAT" | head -1 )
    LST_FILE=$( echo -e "$INPUT_DAT" | tail -1 )

    echo
    ppwide "${TITLE} / Summary"
    echo -e "${Blue}Path${NC}      : ${Green}${SRC_DIR}${NC}"
    echo -e "${Blue}Count${NC}     : ${Green}${INPUT_CNT}${NC}"
    echo -e "${Blue}First File${NC}: ${Green}${FST_FILE}${NC}"
    echo -e "${Blue}Last File${NC} : ${Green}${LST_FILE}${NC}"

    echo
    ppwide "${TITLE} / Report"

    COLS_WIDTH="%5s  %5s  %-20s  %-4s  %s \n"
    printf "$COLS_WIDTH" 'Row' 'Size' 'Datetime' 'Type' 'File'
    wline

    i=0
    while IFS= read -r LINE; do
        SIZE=$(echo "$LINE" | awk '{print $1}')
        FILE=$(echo "$LINE" | awk '{print $2}')
        iTrace "FILE: ${FILE}"
        iTrace "FILE: ${FILE}"

        # new
        COLOR="${NORMAL}"
        if [ -d "$FILE" ]; then
            # dir
            COLOR="${CYAN}"
            DATE=$( ls -l -D '%Y-%m-%d %T' | grep '^d' | grep " ${FILE}\$" | awk '{print $6, $7}' )
            SIZE=$( du -h -dl "${FILE}" | awk '{print $1}' )
            TYPE="Dir"
            iTrace "${DATE} :: ${TYPE} :: ${FILE}"
        elif [ -f "$FILE" ]; then
            # file
            DATE=$( ls -l -D '%Y-%m-%d %T' | grep " ${FILE}\$" | awk '{print $6, $7}' )
            TYPE="Misc"
            LS_LINE=$( ls -l ${FILE} )
            iDebug "${LS_LINE}"
            [ 'x' = ${LS_LINE:3:1} ] && TYPE="EXE" && COLOR="${RED}"
            [ '-' = ${LS_LINE:3:1} ] && TYPE="DAT"
            [ 0 -eq "$( echo $LS_LINE | grep -Eq '.md$' ) $?" ] && TYPE="DOC" && COLOR="${BLUE}"
            [ 0 -eq "$( echo $LS_LINE | grep -Eq '.py$|.sh$' ) $?" ] && TYPE="EXE" && COLOR="${RED}"
            [ 0 -eq "$( echo $LS_LINE | grep -Eq '.dat$|.json$|.tab$|.tml$|.toml$|.txt$|.yaml$|.yml$' ) $?" ] && TYPE="DAT" && COLOR="${LIME_YELLOW}"
            iTrace "${DATE} :: ${TYPE} :: ${FILE}"
        fi

        if [ -n "$DATE" ]; then 
            i=$(( i + 1 ))
            printf "$COLS_WIDTH" "${i}." "$SIZE" "$DATE" "${COLOR}${TYPE}${NORMAL}" "${COLOR}${FILE}${NORMAL}"
        fi
    done < <( du -ah | sort -rh | grep -v './.*/.*' | awk 'BEGIN{FS=OFS=" "} {gsub(/\.\//, "\t", $2)} 1' )

    wline

    # restore dir
    cd "$CUR_DIR" || exit 1
}

function iLog() {
    # usage:    iLog [0|1|10|20|30|40|50] ["Log Message"] ###
    # Setting:  export LOGLEVEL=[TRACE|DEBUG|INFO|SUCCESS|WARNING|ERROR|CRITICAL]
    # Option:   export LOG_DATE=1
    # Default:  INFO level 10
    if [ -n "$LOGLEVEL" ]; then
        [ "$LOGLEVEL" = "TRACE"    ] && LV=0
        [ "$LOGLEVEL" = "DEBUG"    ] && LV=1
        [ "$LOGLEVEL" = "INFO"     ] && LV=10
        [ "$LOGLEVEL" = "SUCCESS"  ] && LV=20
        [ "$LOGLEVEL" = "WARNING"  ] && LV=30
        [ "$LOGLEVEL" = "ERROR"    ] && LV=40
        [ "$LOGLEVEL" = "CRITICAL" ] && LV=50
    else
        LOGLEVEL='INFO' && LV=10
    fi

    [ -z "$IsDemo" ] && DEMO=0 || DEMO=1
    local dt=''; [ -n "$LOG_DATE" ] && dt=" $( get_dt )"
    if [ -n "$2" ]; then
        lv=$1; lv=$(( lv )); shift
        [[  0 -eq "$lv" && "$lv" -ge "$LV" ]] && echo -e "${Gray}TRACE:${NC}${dt} $*" >&2
        [[  1 -eq "$lv" && "$lv" -ge "$LV" ]] && echo -e "${Yellow}DEBUG:${NC}${dt} $*" >&2
        [[ 10 -eq "$lv" && "$lv" -ge "$LV" ]] && echo -e "${Green}INFO:${NC}${dt} $*" >&2
        [[ 20 -eq "$lv" && "$lv" -ge "$LV" ]] && echo -e "${Green}SUCCESS:${NC}${dt} $*" >&2
        [[ 30 -eq "$lv" && "$lv" -ge "$LV" ]] && echo -e "${Red}WARNING:${NC}${dt} $*" >&2
        [[ 40 -eq "$lv" && "$lv" -ge "$LV" ]] && echo -e "${Red}ERROR:${NC}${dt} $*" >&2
        [[ 50 -eq "$lv" && "$lv" -ge "$LV" && 0 -eq "$DEMO" ]] && echo -e "${Red}CRITICAL:${NC}${dt}  $*" >&2 && exit 1
        [[ 50 -eq "$lv" && "$lv" -ge "$LV" && 1 -eq "$DEMO" ]] && echo -e "${Red}CRITICAL:${NC}${dt}  $* ${iYellow}Demo Mode Won't Exit!${NC}" >&2
    fi
    true
    return 
}

function isDebug()   {
    # usage: [ 0 -eq "$( isDebug ) $?" ] && echo "true" || echo "false" ###
    if [[ -n "$LOGLEVEL" && "$LOGLEVEL" == "DEBUG" ]]; then
        true
        return
    else
        false
        return
    fi
}

function isOsx()   {
    # usage: [ 0 -eq "$( isOsx ) $?" ] && echo "true" || echo "false" ###
    local os
    os=$(uname -s)
    if [[ 'Darwin' = "$os" ]]; then
        true
        return
    else
        false
        return
    fi
}

function isTrace()   {
    # usage: [ 0 -eq "$( isTrace ) $?" ] && echo "true" || echo "false" ###
    if [[ -n "$LOGLEVEL" && "$LOGLEVEL" == "TRACE" ]]; then
        true
        return
    else
        false
        return
    fi
}

function iTrace() { 
    # usage: iTrace "Trace message" ###
    iLog  0 "$@"; 
}

function iDebug() { 
    # usage: iDebug "Debug message" ###
    iLog  1 "$@"; 
}

function iInfo() { 
    # usage: iInfo "Info message" ###
    iLog 10 "$@"
}

function iSuccess() { 
    # usage: iSuccess "Success message" ###
    iLog 20 "$@"
}

function iWarning() { 
    # usage: iWarning "Warning message" ###
    iLog 30 "$@"
}

function iError() { 
    # usage: iError "Error message" ###
    iLog 40 "$@"
}

function iAbort() { 
    # usage: iAbort "Abort message" # && exit 1 ###
    iLog 50 "$@"
}

function iCrirical() { 
    # usage: iCrirical "Crirical message" # &&e xit 1 ###
    iLog 50 "$@"
}

## Files
function maxfs() {
    # usage [-a|-int] [path] # prints largest file/dir size for path or cur dir ###
    [ 'bash' = "${MY_SHELL}" ] && iTrace "Line: $(func_lineno ${FUNCNAME[0]} 2), ${iYellow}${FUNCNAME[0]}()${NC} ${iCyan}${*}${NC}"
    [ 'zsh'  = "${MY_SHELL}" ] && iTrace "Line: $(( ${(%):-%I} - 3 )), ${iYellow}${funcstack[1]}()${NC} ${iCyan}${*}${NC}"
    # ex:
    #   maxfs -20       # returns top 20 largest files
    #   maxfs -a        # returns all files, largest to smallest
    #   maxfs -a www   # returns all files, largest to smallest for www directory
    local LIMIT HEAD TMP CUR_DIR LINES IFS LINE SIZE TIME TYPE COLOR DATE FILE LINE_DATA
    LIMT=20
    CUR_DIR=$(pwd)
    while [ $# -gt 0 ]; do
        iTrace "Arg   : '$1'"
        case $1 in
            # option
            -a|--all)
                LIMIT=0
                HEAD="${Yellow}All${NC}"
                iTrace "${HEAD}"
                shift;;
            -*)
                TMP="$1"
                iTrace "-TMP  : $TMP"
                TMP="${TMP:1}"
                iTrace "TMP   : $TMP"
                [ 0 -eq "$(isInt ${TMP}) $?" ] && LIMIT="${TMP}"
                HEAD="Top ${Yellow}${LIMIT}${NC}"
                iTrace "${HEAD}"
                shift;;
            *)
                DIR="$1"
                iTrace "DIR   : $DIR"
                shift;;
        esac
    done

    [ -n "$DIR" ] && cd "$DIR" && iTrace "Go TO : ${DIR}"

    echo -e "${HEAD} Largets Files in: ${Blue}$(pwd)${NC}"
    if [ -z "$ZSH_VERSION" ]; then
        wline
        HEAD_ROW="%4s   %-6s  %-17s %-5s %s\n"
        printf "$HEAD_ROW" "#" "Size" "Changed Time" "Type" "File or Directory"
        wline
        LINES=$(du -h -x -s --time=ctime -- * | sort -r -h)
    else
        # OSX
        # find ./ -type f -size +1000k -exec ls -lht {} \; \
        # | awk '{ print $5" "$1" "$6" "$7" "$8" "$9 }' | sort -r -h
        wline
        HEAD_ROW="%4s   %-6s  %-19s  %-4s  %s\n"
        printf "$HEAD_ROW" "#" "Size" "Changed Time" "Type" "File or Directory"
        wline
        LINES=''
        i=0
        while IFS= read -r LINE; do
            [ '.' = "$(echo "$LINE" | awk '{print $2}')" ] && continue
            i=$(( ++i ))
            [[ 0 -ne "$LIMIT" && "$i" -gt "$LIMIT" ]] && continue
            SIZE=$(echo "$LINE" | awk '{print $1}')
            FILE=$(echo "$LINE" | awk '{print $2}')
            iTrace "${FILE}"

            if [ -d "$FILE" ]; then
                TYPE="Dir"
                COLOR="${Blue}"
                SIZE=$(du -h -dl "${FILE}" | awk '{print $1}')
                iTrace "${SIZE}"
                DATE=$(ls -l -D '%Y-%m-%d %T' | grep '^dr' | grep " ${FILE}\$" | awk '{print $6, $7}')
            else
                TYPE="File"
                COLOR="${Green}"
                iTrace "${SIZE}"
                DATE=$(ls -l -D '%Y-%m-%d %T' | grep " ${FILE}\$" | awk '{print $6, $7}')
            fi
            iTrace "${DATE}"
            LINE_DATA="${DATE} ${SIZE} ${TYPE} ${FILE}"
            iDebug "LINE DATA: ${LINE_DATA}"
            # Exclude hidden files - They don't have date
            [ 5 -gt "${#DATE}" ] && continue
            echo -e "$(jstr -w 4 -r $i).  $(jstr -w 6 -r $SIZE)  $(jstr -w 19 $DATE)  ${COLOR}$(jstr -w 4 $TYPE)${NC}  ${COLOR}${FILE}${NC}"
        done < <(du -ah | sort -rh | grep -v './.*/.*' | awk 'BEGIN{FS=OFS=" "} {gsub(/\.\//, "\t", $2)} 1')

        iTrace "LINES: \n${LINES}"
    fi
    
    [ 0 -ne "$LIMIT" ] && LINES=$(echo -e ${LINES} | head -${LIMIT})
    
    i=0
    while IFS= read -r LINE; do
        i=$(( ++i ))
        SIZE=$(echo "$LINE" | awk '{print $1}')
        TIME=$(echo "$LINE" | awk '{print $2" "$3}')
        FILE=$(echo "$LINE" | awk '{$1="";$2="";$3="";print $0}' | sed 's/^ //')
        [ -d "$FILE" ] && TYPE="Dir" || TYPE="File"
        [ -d "$FILE" ] && COLR="${Magenta}" || COLR="${Green}"
    done < <(printf '%s\n' "${LINES}")
    [ -n "$DIR" ] && cd "$CUR_DIR" && iTrace "Go To : ${CUR_DIR}"
}

function xdiff() {
    ## usage: xdiff "$file" # returns diff of file with previous file ###
    local cur_dir new_dir input files f l
    cur_dir=$(pwd)
    new_dir="$HOME/www"
    input="$1"
    cd $new_dir
    files=$(find . | grep -v 'venv' | grep "/${input}\$")
    while read -r l; do 
        match_files+="$l "
        [ -f "$f" ] && diff $f $l
        f="$l"
    done < <(echo $files)

    while read -r l; do 
        ls -l $l
    done < <(echo $files)
    cd $cur_dir
    iInfo "Lookup: $new_dir"
    iInfo "grep   : /${input}\$"
    iDebug "CurDir: $cur_dir"
}

function y2jwc() {
    # usage: "$dir" # returns comparison of Yaml to Json & Compact Json ###
    [ 'bash' = "${MY_SHELL}" ] && iTrace "Line: $(func_lineno ${FUNCNAME[0]} 2), ${iYellow}${FUNCNAME[0]}()${NC} ${iCyan}${*}${NC}"
    [ 'zsh'  = "${MY_SHELL}" ] && iTrace "Line: $(( ${(%):-%I} - 3 )), ${iYellow}${funcstack[1]}()${NC} ${iCyan}${*}${NC}"
    local lookup_dir exts wdir i files file yaml_chars json_chars comp_chars min_chars col1 col2 col3
    
    lookup_dir="$1"
    exts=( cf cft json template yaml yml yl )
    # shellcheck disable=SC2086
    files=$(ls -1 $dir)
    total_yaml=0
    total_json=0
    total_comp=0
    [ -n "$dir" ] && wdir="$(pwd)/${lookup_dir}" || wdir="$(pwd)"

    function display_facts() {
        # Dispaly Facts
        echo -e "${Blue}Calling Dir ${NC}: ${Green}$(pwd)${NC}"
        echo -e "${Blue}Lookup  Dir ${NC}: ${Green}${dir}${NC}"
        echo -e "${Blue}Working Dir ${NC}: ${Green}${wdir}${NC}"
        echo
    }
    display_facts

    Head_COLS="%5s %12s  %12s  %12s  %s\n"

    printf "${Head_COLS}" "#" "Yaml Chars" "Json Chars" "Json Compact" "File"
    wline
    i=0
     # shellcheck disable=SC1009
    for file in $files; do
        [ -d "${wdir}/${file}" ] && iTrace "Skipping Directory : ${wdir}/${file}" && continue
        ext=$( echo "${file}" | tr '.' ' ' | awk '{print $NF}' )
        # shellcheck disable=SC1073,SC1072
        [ 1 -eq $(inarr "${ext}" "${exts[@]}") $? ] && iTrace "Skipping not whitelisted Extention : .${ext}" && continue
        i=$(( i + 1 ))
        yaml_chars=$(cat "${wdir}/${file}" | wc -m)
        json_chars=$(cat "${wdir}/${file}" | yq '.' | wc -m)
        comp_chars=$(cat "${wdir}/${file}" | yq '.' | jq -c '.' | wc -m)

        min_chars=$(echo "${yaml_chars} ${json_chars} ${comp_chars}" | awk '{for (;NF-1;NF--) if ($1>$NF) $1=$NF} 1')
        iDebug "Min: ${min_chars}"
        col1='';col2='';col3='';
        [ "$yaml_chars" -eq "$min_chars" ] && col1="${Green}" && iDebug "Min is Yaml    : ${min_chars}"
        [ "$json_chars" -eq "$min_chars" ] && col2="${Green}" && iDebug "Min is Json    : ${min_chars}"
        [ "$comp_chars" -eq "$min_chars" ] && col3="${Green}" && iDebug "Min is Compact : ${min_chars}"
        ROWS_COLS="%5s ${col1}%'12d${NC}  ${col2}%'12d${NC}  ${col3}%'12d${NC}  %s\n"

        total_yaml=$(( total_yaml+yaml_chars ))
        total_json=$(( total_json+json_chars ))
        total_comp=$(( total_comp+comp_chars ))
        printf "${ROWS_COLS}" "$i" "$yaml_chars" "$json_chars" "${comp_chars}" "$file"
    done
    min_chars=$(echo "${total_yaml} ${total_json} ${total_comp}" | awk '{for (;NF-1;NF--) if ($1>$NF) $1=$NF} 1')
    iDebug "Min: ${min_chars}"
    col1='';col2='';col3='';
    [ "$total_yaml" -eq "$min_chars" ] && col1="${Green}" && iDebug "Min is Yaml    : ${min_chars}"
    [ "$total_json" -eq "$min_chars" ] && col2="${Green}" && iDebug "Min is Json    : ${min_chars}"
    [ "$total_comp" -eq "$min_chars" ] && col3="${Green}" && iDebug "Min is Compact : ${min_chars}"
    ROWS_COLS="%5s ${col1}%'12d${NC}  ${col2}%'12d${NC}  ${col3}%'12d${NC}  %s\n"
    wline
    printf "${ROWS_COLS}" "$i" "$total_yaml" "$total_json" "$total_comp" "Total for ${i} Files"
    wline
    Head_COLS="%5s ${col1}%12s${NC}  ${col2}%12s${NC}$  ${col3}%12s${NC}  %s\n"
    printf "${Head_COLS}" "" "Yaml Chars" "Json Chars" "Json Compact"
    echo

    # Dispaly Facts
    display_facts
}

## Str, Int & Arr
function dedent() {
    # usage: dedent "str" # returns dedented str ###
    echo "$1" | sed 's/^[[:space:]]*//'
}

function get_maxlen() {
    # usage: get_maxlen "abc abcdef abcd" # Returns 6 ###
    local maaxLen obj
    maxLen=0
    for obj in $@; do 
        [[ "${#obj}" -ge "$maxLen" ]] && maxLen=${#obj}
    done
    echo "$maxLen"
}

function inStr() {
    # usage: inStr "string" "substring" ###
    [ -z "$1" ] && echo "" && return
    [ -z "$2" ] && echo "" && return
    echo -e "$1" | grep -Eq "$2" && echo 0 || echo 1
}

function ndigits() {
    # usage: ndigits "int" [digits] # echo left zero str ###
    iTrace "Line: $(( ${(%):-%I} - 2 )), ${iYellow}${funcstack[1]}()${NC} ${iCyan}${*}${NC}"
    [ -z "$1" ] && iError "${funcstack[1]} missing required 1st param" && echo ""
    local str=$1
    local width=3
    local i=1
    [ -n "$2" ] && width=$2
    while [ "${#str}" -lt "$width" ]; do str="0$str"; done
    echo "$str"
}

function ltrim() {
    # usage: "$str" # returns left trimmed ###
    echo "$*" | sed 's/^ *//' 
}

function rtrim() {
    # usage: "$str" # returns right trimmed ###
    echo "$*" | sed 's/ *$//' 
}

function trim() {
    # usage: "$str" # returns right & left trimmed ###
    echo "$*" | sed 's/^[ \t]*//;s/[ \t]*$//'
}

function lspace() {
    # usage: lspace "str" [width] # echo left spaced str ###
    [ -z "$1" ] && iError "${funcstack[1]} missing required 1st param" && echo ""
    local str=$1
    local width=5
    local i=1
    [ -n "$2" ] && width=$2
    for (( i=1; i<width; i++ )); do str=" $str"; done
    echo "$str"
}

function rspace() {
    # usage: rspace "str" [width] # echo right spaced str ###
    [ -z "$1" ] && iError "${funcstack[1]} missing required 1st param" && echo ""
    local str=$1
    local width=5
    local i=1
    [ -n "$2" ] && width=$2
    for (( i=1; i<width; i++ )); do str="$str "; done
    echo "$str"
}

function get_tb() {
    # usage: get_tb ["My custom message"] ###
    echo 'Traceback (most recent call last):'
    STACK=''
    local i=0
    local ind='  '
    local indent=''
    local message="${1:-""}"
    local stack_size=${#FUNCNAME[@]}
    # to avoid noise we start with 1 to skip the get_tb function
    for (( i=1; i<stack_size; i++ )); do
        indent+=$ind
        local func="${FUNCNAME[$i]}"
        [[ $func = "" ]] && func=MAIN
        local linen="${BASH_LINENO[$(( i - 1 ))]}"
        local src="${BASH_SOURCE[$i]}"
        [[ "$src" = "" ]] && src=non_file_source

        STACK+=$'\n'"$indent File $src, line $linen in $func()"
    done
    STACK="${message}${STACK}"
    echo "$STACK"
}

function isInt() {
    # usage: [ 0 -eq "$( is_int "$chk') $?" ] && echo "true" || echo "false" ###
    iTrace "Line: $(( ${(%):-%I} - 2 )), ${iYellow}${funcstack[1]}()${NC} ${iCyan}${*}${NC}"
    if [[ "$1" =~ ^[0-9]+$ ]] ; then
        iTrace "$1 is an integer"
        true
        return
    else
        iTrace "$1 is not an integer!"
        false
        return
    fi
}

function is_int() {
    # usage: is_int "$chk" # returns true if integer or false ###
    isInt "$*"
}

function title_case() {
    # usage: "$text" # returns Title Case ###
    iTrace "Line: $(( ${(%):-%I} - 2 )), ${iYellow}${funcstack[1]}()${NC} ${iCyan}${*}${NC}"
    "$PY" -c "print('$*'.title())"
}

## Print
function hline() {
    # usage: hline "Heading Text" # echo a heading line followed by a line of dashes ###
    [ 'bash' = "${MY_SHELL}" ] && iTrace "Line: $(func_lineno ${FUNCNAME[0]} 2), ${iYellow}${FUNCNAME[0]}()${NC} ${iCyan}${*}${NC}"
    [ 'zsh'  = "${MY_SHELL}" ] && iTrace "Line: $(( ${(%):-%I} - 3 )), ${iYellow}${funcstack[1]}()${NC} ${iCyan}${*}${NC}"
    local REP WIDTH i line
    WIDTH=90
    REP='-'
    for (( i=0; i < WIDTH; i++ )); do line+="${REP}"; done
    echo "$*"
    echo "$line"
}

function pline() {
    # usage: pline "Left Text" "Right Text" # echo a line with left and right aligned text ###
    [ 'bash' = "${MY_SHELL}" ] && iTrace "Line: $(func_lineno ${FUNCNAME[0]} 2), ${iYellow}${FUNCNAME[0]}()${NC} ${iCyan}${*}${NC}"
    [ 'zsh'  = "${MY_SHELL}" ] && iTrace "Line: $(( ${(%):-%I} - 3 )), ${iYellow}${funcstack[1]}()${NC} ${iCyan}${*}${NC}"
    local PADDING LT RT
    PADDING="............................................................"
    LT="$1"
    RT="$2"
    printf "%s %s %s\n" "$LT" "${PADDING:${#LT}}" "$RT"
}

function wline() {
    # usage: wline: ['-' 90 | 90 ] - print '-' 90 chars length ###
    iTrace "Line: $(( ${(%):-%I} - 2 )), ${iYellow}${funcstack[1]}()${NC} ${iCyan}${*}${NC}"
    local i len char res
    for arg in "$@"; do args+="'${arg}' "; done
    char='-'
    len=90
    res=''

    # char len
    if [ -n "$2" ]; then
        char="$1"
        len="$2"
    # char or len
    elif [ -n "$1" ]; then
        if [ 0 -eq "$( is_int $1 ) $?" ]; then
            iDebug "$1 is an integer"
            len="$1"
        else
            iDebug "$1 is not an integer!"
            char="$1"
        fi
    fi

    for (( i=0; i<len; i++ )); do
        res="${res}${char}"
    done
    echo "$res"
}

function spc() {
    # usage: spc length: returns space to lenght ###
    iTrace "Line: $(( ${(%):-%I} - 2 )), ${iYellow}${funcstack[1]}()${NC} ${iCyan}${*}${NC}"
    local len res
    len="$1"
    res=''
    [ 1 -eq $(is_int "${len}") $? ] && iTrace "${len} is not integer!" && return
    while [ "${#res}" -lt "$len" ]; do res=" ${res}"; done
    echo "${res}"
}

function ppwide() {
    # usage: [-b '-'] [-a '-'] [-w int] ['Message'] \n# prints bbb 'Message' aaa... # to w chars wide ###
    [ 'bash' = "${MY_SHELL}" ] && iTrace "Line: $(func_lineno ${FUNCNAME[0]} 2), ${iYellow}${FUNCNAME[0]}()${NC} ${iCyan}${*}${NC}"
    [ 'zsh'  = "${MY_SHELL}" ] && iTrace "Line: $(( ${(%):-%I} - 3 )), ${iYellow}${funcstack[1]}()${NC} ${iCyan}${*}${NC}"
    local str before after color width h message oneChar sStr
    before=''
    after=''
    str='#'
    width=90
    while [ $# -gt 0 ]; do
        case $1 in
            # options
            -h|--help)
                h=1
                shift;;
            # kwargs
            -b|--before)
                before="$2"
                shift;shift;;
            -a|--after)
                after="$2"
                shift;shift;;
            -c|--color)
                color="$2"
                shift;shift;;
            -w|--width)
                width="$2"
                shift;shift;;
            *)
                message="$1"
                shift;;
        esac
    done

    if [ -n "$h" ]; then
        echo "usage: [-b '-'] [-a '-'] [-w int] ['Message']"
        wline
        echo "args:"
        echo "  -h  --help      show this help and exit"
        echo "  -b  --before    leading one char, default #"
        echo "  -a  --after     trailing one char, default #"
        echo "  -c  --color     output color, default none"
        echo "  -w  --width     output width, default 90 characters"
        echo "                      no arg then prints # to 90 chars wide"      
        echo 
        return
    fi
    width=$(( width - 1 ))
    rep="$(wline '#' "$width")"
    iTrace "message : '$message'"
    [ -n "$message" ] && str="### $message"
    [ -n "$before" ] && str=${str//#/$before}
    [[ -n "$before" && -z "$after" ]] && after="${before}"
    iTrace "--before '$before' --after '$after' --color '$color' --width ${width} '${str}'"
    if [[ -n "$message" && 1 == "${#message}" ]]; then
        oneChar=1
        str="$message"
        rep="#${rep}"
        rep=${rep//#/$str}
    elif [ -z "$message" ]; then
        oneChar=1
        rep="#${rep}"
        str="#"
    fi
    [ -n "$before" ] && str="$( echo "${str}" | sed "s/#/$before/g" )"
    [ -n "$after" ] && rep="$( echo "${rep}" | sed "s/#/$after/g" )"
    # e\[4;93m
    sStr=$( echo -e "$str" | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g" )
    # e\[38;5;94m
    sStr=$( echo -e "$str" | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?(;[0-9]{1,2})?)?[m|K]//g" )
    iTrace "--before '$before' --after '$after' --color '$color' --width ${width} '${sStr}'"
    if [ 'bash' = "${MY_SHELL}" ]; then
        color="${!color}"
        iTrace "Line: $(( LINENO )), ${MY_SHELL}, '${color}'"
    else
        color="${(P)color}"
        iTrace "Line: $(( ${(%):-%I} )), ${MY_SHELL}, '${color}'"
    fi
    if [ -n "${color}" ]; then
        [ -n "$oneChar" ] && echo -e "${color}${str}${color}${rep:${#sStr}}${NC}" || echo -e "${color}${str} ${color}${rep:${#sStr}}${NC}"
    else
        [ -n "$oneChar" ] && echo -e "${str}${rep:${#sStr}}" || echo -e "${str} ${rep:${#sStr}}"
    fi
}

function jstr-help() {
    # usage: jstr-help: called by jstr to show its help and exit ###
    echo "Justify String"
    wline
    echo "args:"
    echo "  -h              show this help and exit"
    echo "  -c  --center    center align"
    echo "  -l  --left      left align"
    echo "  -r  --right     right align"
    echo "  -w  --width     final width"
}

function jstr() {
    # usage: jstr "$str" --width [-l|-c|-r]: prints justifed input ###
    iTrace "Line: $(( ${(%):-%I} - 2 )), ${iYellow}${funcstack[1]}()${NC} ${iCyan}${*}${NC}"
    local args align width str pad new_width
    iTrace "Given: $@"
    args=()
    align='left'
    while [ $# -gt 0 ]; do
        case "$1" in
            # options
            --left|-l)
                align='left'
                shift
                ;;
            --center|-c)
                align='center'
                shift
                ;;
            --right|-r)
                align='right'
                shift
                ;;
            # kargs
            --width|-w)
                width="$2"
                shift
                shift
                ;;
            --help|-h)
                jstr-help
                return
                ;;
            --|-)
                shift
                while [ $# -gt 0 ]; do args+=("$1"); shift; done;
                break;
                ;;
            --*|-*)
                iWarning "**Bad parameter: $1**"
                jstr-help
                exit 1
                ;;
            *)
                str="$1"
                args+=("$1");
                shift
                ;;
        esac
    done

    iTrace "Print ${Yellow}${str}${NC} ${Blue}--${align}${NC} --width ${Green}${width}${NC}"
    [ -z "$width" ] && iTrace "Missing required arg --width" && return

    # process
    if [ 'left' = "$align" ]; then
        while [ ${#str} -lt $width ]; do str="${str} "; done
        iTrace "${Blue}'${str}'${NC}"
    elif [ 'center' = "$align" ]; then
        while [ ${#str} -lt $width ]; do str=" ${str} "; done
        iTrace "${Green}'${str}'${NC}"
    elif [ 'right' = "$align" ]; then
        while [ ${#str} -lt $width ]; do str=" ${str}"; done
        iTrace "${Red}'${str}'${NC}"
    fi
    echo "${str}"
}

function pyg_styles() {
    # usage: pyg_styles: prints all pygments styles ###
    local CMD
    iTrace "Line: $(( ${(%):-%I} - 2 )), ${iYellow}${funcstack[1]}()${NC} ${iCyan}${*}${NC}"
CMD="
from pygments.styles import get_all_styles

for style in list(get_all_styles()):
    print(style)
"
    echo $( "$PY" -c "$CMD" | tr '\n' ' ' )
}

function pyg_out() {
    # usage: pyg_out "$code" ["$lang"]: prints pygmentize code in monokai style ###
    local lang code
    iTrace "Line: $(( ${(%):-%I} - 2 )), ${iYellow}${funcstack[1]}()${NC} ${iCyan}${*}${NC}"
    lang='bash'
    if [ -n "$2" ]; then
        code="$2"
        lang="$1"
    else
        code="$1"
    fi
    echo "$code" | pygmentize -l "$lang" -O style=monokai
}

## Date & Time
function iso_dt() {
    # usage: iso_dt [-s] returns ISO date & time ###
$PY -c "
import datetime
from datetime import date, datetime, timezone, timedelta
dt = datetime.now(timezone.utc).isoformat()
print(dt[0:18] + dt[24:])
"
    # [ -z "$1" ] && date -u +%Y-%m-%dT%H:%M:%S.%s%z || date -u +%Y-%m-%dT%H:%M:%S%z
}

function dt2ts() {
    # usage: $1 returns ts from given dt ###
$PY -c "
import datetime
from datetime import date, datetime, timezone, timedelta
dt = '"$1"'
print(datetime.fromisoformat(dt).timestamp())
"
#     dt=$( echo "$1" | sed 's/Z/-0000/g' )
#     if [ 0 -eq "$( isOsx ) $?" ]; then
#         date -j -f '%Y-%m-%dT%H:%M:%S' "$dt" "+%s"
#     else
#         date --date="$dt" +"%s"
#     fi
}

function ts2dt() {
    # usage: $1 returns dt from given ts ###
$PY -c "
import datetime
from datetime import date, datetime, timezone, timedelta
ts = $1
print(datetime.fromtimestamp(ts).isoformat())
"
    # ts=$( echo "$1" | tr '.' ' ' | awk '{print $1}' )
    # if [ 0 -eq "$( isOsx ) $?" ]; then
    #     date -r "$ts" '+%Y-%m-%dT%H:%M:%S%z'
    # else
    #     date --date="$ts" '+%Y-%m-%dT%H:%M:%S%z'
    # fi
}

function sec_disp() {
    # usage: [-b] # show brief hh:mm:ss
    local brief secs d a h m s sd sh sm ss sInt
    iTrace "${Blue}function${NC} ${Yellow}${funcstack[1]}()${NC}"
    while [ $# -gt 0 ]; do
        case $1 in
            # options
            -b)
                brief=1
                shift;;
            -*)
                brief=1
                shift;;
            *)
                secs="$1"
                shift;;
        esac
    done

    # calculate elements & set singular or plural
    d=$("$PY" -c "print(int($secs/60/60/24))"); [ "$d" -eq 1 ] && sd='Day' || sd='Days'
    iTrace "${sd}: $d"
    h=$("$PY" -c "print(int($secs/60/60%24))"); [ "$h" -eq 1 ] && sh='Hour' || sh='Hours'
    iTrace "${sh}: $h"
    m=$("$PY" -c "print(int($secs/60%60))"); [ "$m" -eq 1 ] && sm='Minute' || sm='Minutes'
    iTrace "${sm}: $m"
    s=$("$PY" -c "print(float(format($secs%60, '.6f')))"); sInt=$(echo "$s" | tr '.' ' ' | awk '{print $1}')
    [ "$sInt" -eq 1 ] && ss='Second' || ss='Seconds'
    iTrace "${ss}: $s"
    # exclude 0 values from output
    if [ -n "$brief" ]; then
        [ 0 -ne "$d" ] && echo -n "${d} ${sd} "
        printf "%02d:%02d:%02d\n" "$h" "$m" "$s"
    else
        [ "$d" -gt 0 ] && a=1 && echo -n "${d} ${sd} "
        [ "$h" -gt 0 ] && a=1 && echo -n "${h} ${sh} "
        [ "$m" -gt 0 ] && a=1 && echo -n "${m} ${sm} "
        [ -n "$a" ] && echo -n '& '
        echo "${s} ${ss}"
    fi
}

function get_dt() {
    # usage: get_dt # returns +Y-m-d H:M:S ###
    date '+%Y-%m-%d% %H:%M:%S'
}

function get_ts() {
    # usage: get_ts: prints current ts in s with 3 decimals ###
    # Formats: +%s.%3N +%s.%6N +%s.%9N +%s.%12N or +%s.%N
    local os
    os=$( uname -s )
    # shellcheck disable=SC2015
    [ 'Darwin' = "$os" ] && gdate +%s.%6N || date +%s.%6N
}

function took_ts() {
    # usage: took_ts "$ts": echo timedelta of input $ts & now ###
    if [ -n "$1" ]; then
        local ts os now took
        ts="$1"
        os=$( uname -s )
        [ 'Darwin' = "$os" ] && now=$( gdate +%s.%6N ) || now=$( date +%s.%6N )
        took=$( echo "scale=6; ${now} - ${ts}" | bc )
        echo "${took}"
    fi
}

function get_fmtdate() {
    # usage: get_fmtdate: echo full date with tz ###
    local os
    os=$( uname -s )
    # shellcheck disable=SC2015
    [ 'Darwin' = "$os" ] && gdate '+%a %d-%b-%Y  %H:%M:%S.%3N %z %Z' || date '+%a %d-%b-%Y  %H:%M:%S.%3N %z %Z'
}

function timeit() {
    # usage: timeit "str": echo "${current_timestamp} ${str}" ###
    echo "$( get_ts ) ${1}"
}

function timedelta_mhsm() {
    # usage: timedelta_mhsm "$secs": print formatted secs as \nHH:MM:SS.000 ###
    local secs
    secs="$1"
    # shellcheck disable=SC2183,SC2046
    printf '%02d:%02d:%06.3f\n' $( "$PY" -c "print(int($secs/3600));print(int($secs%3600/60));print(float(format($secs%60, '.6f')))" )
}

## Str, Int & array Conversions
function arr2csv() {
    # usage: $arr[@] # returns csv  ###
    [ 'bash' = "${MY_SHELL}" ] && iTrace "Line: $(func_lineno ${FUNCNAME[0]} 2), ${iYellow}${FUNCNAME[0]}()${NC} ${iCyan}${*}${NC}" 
    [ 'zsh'  = "${MY_SHELL}" ] && iTrace "Line: $(( ${(%):-%I} - 3 )), ${iYellow}${funcstack[1]}()${NC} ${iCyan}${*}${NC}"
    echo "$*" | tr ' ' ',' 
}

function arr_pop() {
    # usage: ($( arr_pop --arr $(arr2csv "${arr[@]}") --pop $(arr2csv "${pop[@]}") )) ###
    [ 'bash' = "${MY_SHELL}" ] && iTrace "Line: $(func_lineno ${FUNCNAME[0]} 2), ${iYellow}${FUNCNAME[0]}()${NC} ${iCyan}${*}${NC}" 
    [ 'zsh'  = "${MY_SHELL}" ] && iTrace "Line: $(( ${(%):-%I} - 3 )), ${iYellow}${funcstack[1]}()${NC} ${iCyan}${*}${NC}"
    local h pop arr msg needle res
    while [ $# -gt 0 ]; do
        case $1 in
            # options
            -h|--help)
                h=1
                shift;;
            # kwargs
            -a|--arr)
                arr=($( echo "$2" | tr ',' ' ' ))
                shift;shift;;            
            -p|--pop)
                pop=($( echo "$2" | tr ',' ' ' ))
                shift;shift;;
            *)
                msg="$1"
                shift;;
        esac
    done
    if [ -n "$h" ]; then
        echo 'Usage: res=($( arr_pop --arr $(arr2csv "${arr[@]}") --pop $(arr2csv "${pop[@]}") ))'
        wline
        echo "options:"
        echo "  -h  --help  show this help and exit"
        echo
        echo "args:"
        echo "  -a  --arr   array to pop"
        echo "  -p  --pop   string or array to pop from"
        return
    fi

    iTrace "${#arr[@]} arr : ${arr[@]}"
    iTrace "${#pop[@]} pop : ${pop[@]}"
    iTrace "is '${Red}${pop[@]}${NC}' in '${Yellow}${arr[@]}${NC}'"
    needle=$( echo ${pop[@]} | tr ' ' '|' | sed 's/\n//' )
    iTrace "${#pop[@]} ne  : ${needle}"
    res=($(echo ${arr[@]} | tr ' ' '\n' | grep -E -v "$needle" | tr '\n' ' '))
    iTrace "${#res[@]} res : ${res[@]}"        

    echo "${res[@]}"
}

function inarr() {
    # usage: [ 0 -eq $( inarr "needle" "${arr[@]}") $? ] \n&& echo "True" || echo "False" ###
    iTrace "Line: $(( ${(%):-%I} - 3 )), ${iYellow}${funcstack[1]}()${NC} ${iCyan}${*}${NC}"
    local ne arr
    ne="$1"; shift
    iTrace "Needle : '$ne'"
    # shellcheck disable=SC2206
    arr=( $* )
    iTrace "${#arr[@]} items in array : '${arr[@]}'"
    i=0
    for k in "${arr[@]}"; do
        i=$(( i + 1 ))
        iTrace "${i}. Comparing '$ne' to '$k'"
        if [ "$k" = "$ne" ]; then
            iDebug "${i}. Found a Match '$ne' = '$k'"
            true
            return
        fi
    done
    iDebug "No Match Found! '$ne' not in '${arr[@]}'"
    false
    return
}

function prcnt() {
    # usage: prcnt 5.2 10 returns 52.00% ###
    local chk total res
    chk="$1"
    total="$2"
    "$PY" -c "print(float(format($chk/$total*100, '.2f')))"
}

function s2n() {
    # usage: returns one char per line for ascii value of all chars input
    [ -z "$1" ] && return
    printf '%s' "$1" | awk -l ordchr -v RS='.{1}' '{s+ord(RT)} END{print s+0}'
}

function spinal2camel() {
    # usage: spinal-text-to-test # returns SpinalTextToTest ###
    [ 'bash' = "${MY_SHELL}" ] && iTrace "Line: $(func_lineno ${FUNCNAME[0]} 2), ${iYellow}${FUNCNAME[0]}()${NC} ${iCyan}${*}${NC}" 
    [ 'zsh'  = "${MY_SHELL}" ] && iTrace "Line: $(( ${(%):-%I} - 3 )), ${iYellow}${funcstack[1]}()${NC} ${iCyan}${*}${NC}"
    "$PY" -c "print('$1'.replace('-',' ').replace('_',' ').title().replace(' ',''))"
}

function snake2camel() {
    # usage: snake_text_to_test # returns SnakeTextToTest ###
    [ 'bash' = "${MY_SHELL}" ] && iTrace "Line: $(func_lineno ${FUNCNAME[0]} 2), ${iYellow}${FUNCNAME[0]}()${NC} ${iCyan}${*}${NC}" 
    [ 'zsh'  = "${MY_SHELL}" ] && iTrace "Line: $(( ${(%):-%I} - 3 )), ${iYellow}${funcstack[1]}()${NC} ${iCyan}${*}${NC}"
    "$PY" -c "print('$1'.replace('-',' ').replace('_',' ').title().replace(' ',''))"
}

function camel2() {
    # usage: camel2 '_|-' "$str" # returns snake for '_' & spinal for '-'' ###
    #  Example:
    #  camel2 '_' "snakeCase"  # returns snake_case
    #  camel2 '_' "SnakeCase"  # returns snake_case
    #  camel2 '-' "spinalCase" # returns spinal-case
    #  camel2 '-' "SpinalCase" # returns spinal-case

    local r="$1"
    local str="$2"
local CMD="
res = ''
str = '$str'
for i, s in enumerate(str):
    if (s.isupper()) and i > 0: res += '$r'   # add separator for upper case except first
    res += s.lower()                          # add lower case
print(res)
"
    "$PY" -c "$CMD"
}

function camelcase() {
    # usage: echo "snake text to test" | camlcase # returns SnakeTextToTest ###
    [ 'bash' = "${MY_SHELL}" ] && iTrace "Line: $(func_lineno ${FUNCNAME[0]} 2), ${iYellow}${FUNCNAME[0]}()${NC} ${iCyan}${*}${NC}" 
    [ 'zsh'  = "${MY_SHELL}" ] && iTrace "Line: $(( ${(%):-%I} - 3 )), ${iYellow}${funcstack[1]}()${NC}"

    # Read from argument
    if [ -n "$1" ]; then
        # Process the input using Python
        "$PY" -c "import sys; print(' '.join(sys.argv[1:]).replace('-',' ').replace('_',' ').title().replace(' ',''))" "$@"
        return
    fi

    # Read input from stdin
    read -r input

    # Process the input using Python
    "$PY" -c "import sys; print(' '.join(sys.stdin.read().split()).replace('-',' ').replace('_',' ').title().replace(' ',''))" <<< "$input"
}

function camel2snake() {
    # usage: InputTextToTestDifferentCases # returns input_text_to_test_different_cases ###
    [ 'bash' = "${MY_SHELL}" ] && iTrace "Line: $(func_lineno ${FUNCNAME[0]} 2), ${iYellow}${FUNCNAME[0]}()${NC} ${iCyan}${*}${NC}" 
    [ 'zsh'  = "${MY_SHELL}" ] && iTrace "Line: $(( ${(%):-%I} - 3 )), ${iYellow}${funcstack[1]}()${NC} ${iCyan}${*}${NC}"
    camel2 '_' "$1"
}

function camel2spinal() {
    # usage: InputTextToTestDifferentCases # returns input-text-to-test-different-cases ###
    [ 'bash' = "${MY_SHELL}" ] && iTrace "Line: $(func_lineno ${FUNCNAME[0]} 2), ${iYellow}${FUNCNAME[0]}()${NC} ${iCyan}${*}${NC}" 
    [ 'zsh'  = "${MY_SHELL}" ] && iTrace "Line: $(( ${(%):-%I} - 3 )), ${iYellow}${funcstack[1]}()${NC} ${iCyan}${*}${NC}"
    camel2 '-' "$1"
}

## AWS Functions
function aws-funcs() {
    ## usage: aws-funcs: prints all aws functions ###
    list-funcs aws cli iam boto 
}

function cli2boto() {
    # usage: get-administrator-account -> get_administrator_account ###
    echo $1 | tr '-' '_'
}

function cli2iam() {
    # usage: [securityhub] get-administrator-account -> [securityhub:]GetAdministratorAccount ###
    [ -n "$2" ] && echo -n "${1}:" && shift
    spinal2camel "$1"
}

function boto2cli() {
    # usage: get_administrator_account -> get-administrator-account ###
    echo $1 | tr '_' '-'
}

function boto2iam() {
    # usage: [securityhub] get_administrator_account -> [securityhub:]GetAdministratorAccount ###
    [ -n "$2" ] && echo -n "${1}:" && shift
    # snake_case to PascalCase
    snake2camel "$1"
}

function iam2boto() {
    # usage: [securityhub:]GetAdministratorAccount -> get_administrator_account ###
    arg="$1"
    if [[ "$1" == *":"* ]]; then
        svc=$( echo "$1" | tr ':' ' ' | awk '{print $1}' )
        arg=$( echo "$1" | tr ':' ' ' | awk '{print $2}' )
        iTrace "svc : $svc"
        iTrace "arg : $arg"
        echo -n "$svc "
    fi
    camel2snake "$arg"
}

function iam2cli() {
    # usage: [securityhub:]GetAdministratorAccount -> [aws securityhub ] get-administrator-account ###
    arg="$1"
    if [[ "$1" == *":"* ]]; then
        svc=$( echo "$1" | tr ':' ' ' | awk '{print $1}' )
        arg=$( echo "$1" | tr ':' ' ' | awk '{print $2}' )
        iTrace "svc : $svc"
        iTrace "arg : $arg"
        echo -n "aws $svc "
    fi
    camel2spinal "$arg"
}

function aws-describe-regions() {
    # usage: aws--describe-regions: prints all regions ###
    aws ec2 describe-regions --query 'Regions[].{Region:RegionName}' --output text
}

function awsCliFilt() {
    # usage: awsCliFilt: returns filter for cli calls ###
    # aws ec2 > ec2 # then open ec2 to copy below line
    echo '       +o '
}

function awsCliFst() {
    # usage: awsCliFst: returns filter for first cli calls ###
    # aws ec2 > ec2 # then open ec2 to copy below line
    echo 'AAVVAAIILLAABBLLEE'  # AVAILABLE [SERVICE|COMMAND]
}

function awsCliLst() {
    # usage: awsCliLst: returns filter for last cli calls ###
    # aws ec2 > ec2 # then open ec2 to copy below line
    echo 'SSEEEE'   # SEE
}

function awsCliColor() {
    # usage: Function to set color based on line value ###
    local line color
    [ -z "$1" ] && return
    line="$1"
    case "$line" in
        # Magenta
        create*|purchase*)
            color="${Magenta}";;

        # Yellow
        accept*|associate*|change*|deregisster*|disassociate*|enable*|reject*|start*|stop*)
            color="${Yellow}";;

        # Orange
        modify*|move*|put*|remove*|replace*|reset*|revoke*|terminate*|unassign*|update*)
            color="${Orange}";;
        
        # Red
        detach*|deactivate*|delete*)
            color="${Red}";;
        
        # Green
        describe*|get*|list*)
            color="${Green}";;
        
        # Default color (you can change this as needed)
        *)
            color="${NC}";;
    esac
    echo "$color"
}

function awsa() {
    # usage: awsa aws-service: prints all read-only cli actions for given service ###
    local WIDTH aTab LEFT_WIDTH LINE_WIDTH FILT SVC EXTRA RES COUNT line Describe Get List
    WIDTH=75
    aTab='    '
    LEFT_WIDTH=$(( WIDTH + 7 ))
    LINE_WIDTH=$(( WIDTH + WIDTH + 7 ))
    FILT="$(awsCliFilt | sed 's/\^H//g')"
    EXCL=":|${FIlT}help"
    LST='SSEEEE'

    SVC="$1"
    [ -n "$SVC" ] && shift

    EXTRA="$*"
    EXTRA="$(echo "$EXTRA" | tr ',' ' ')"
    EXTRA="$(echo "$EXTRA" | tr ' ' '|')"

    # Match fromm AVAILABLE COMMANDS Onward - Only ^A works!?
    RES=$(aws $SVC help | grep -A1000 "$(awsCliFst)" | sed 's/\^H//g')
    COUNT=$(echo -e "$RES" | grep -Ev "$EXCL" | grep -c "$FILT" | awk '{print $1}')
    iDebug "$RES"

    echo -e "$(jstr -w ${LEFT_WIDTH} "CLI Command for ${SVC}") Service Actions"
    wline $LINE_WIDTH

    if [ -n "$EXTRA" ]; then
        RES=$(echo -e "$RES" | grep -Ev "$EXCL" | grep "$FILT" | grep -E "$EXTRA")
    else
        RES=$(echo -e "$RES" | grep -Ev "$EXCL" | grep "$FILT")
    fi
    iDebug "$RES"

    i=0
    while read -r line; do
        [ -z "$line" ] && continue
        i=$(( i + 1 ))
        iStr=$(jstr -r -w 5 "$i")
        line="${line:4}"
        iDebug "Line: $i, $line"
        color=$(awsCliColor "$line")

        # Get IAM Actions
        ACTION=$(cli2iam $SVC $line)
        echo -e "${iStr}. ${color}$(jstr -w ${WIDTH} ${line})${NC} ${iYellow}${ACTION}${NC}"
    done <<< "$RES"

    wline $LINE_WIDTH
    echo -e "$(jstr -w ${LEFT_WIDTH} "CLI Command for ${SVC}") Service Actions"

    echo -e "AWS Service      : ${Yellow}${SVC}${NC}"
    echo -e "AWS CLI Version  : ${Yellow}$(aws --version)${NC}"
    echo -e "Selected Actions : ${Yellow}${i}/${COUNT}${NC}"
    echo -e "Filter Criteria  : ${Yellow}$(echo $EXTRA | sed 's/o //g')${NC}"
    echo -e "${iGreen}Read-only actions${NC}"
    wline $LINE_WIDTH

    [ -n "$Describe" ] && echo -e "${iYellow}${aTab} ${SVC}:Describe*${NC}"
    [ -n "$Get" ] && echo -e "${iYellow}${aTab} ${SVC}:Get*${NC}"
    [ -n "$List" ] && echo -e "${iYellow}${aTab} ${SVC}:List*${NC}"

    echo
    echo -e "Usage: service [${Yellow}Filters${NC}]"
    echo -e "    optional 'Filters' can be either of comma or space separated"
    echo
    echo -e "Example:"
    echo -e "  ${iYellow}awsa ec2 vpc-endpoint instance${NC}"
    echo -e "  Above returns all ec2 actions with keyword of 'vpc-endpoint' or 'instance'"
}

function awsr() {
    # usage: awsa aws-service: prints all read-only cli actions for given service ###
    local WIDTH aTab LEFT_WIDTH LINE_WIDTH FILT SVC EXTRA RES COUNT line Describe Get List
    WIDTH=75
    aTab='    '
    LEFT_WIDTH=$(( WIDTH + 7 ))
    LINE_WIDTH=$(( WIDTH + WIDTH + 7 ))
    FILT="$(awsCliFilt | sed 's/\^H//g')"
    EXCL=":|${FIlT}help"
    LST='SSEEEE'
    SVC="$1"
    shift;

    EXTRA="o describe|o get|o list"

    # Match fromm AVAILABLE COMMANDS Onward - Only ^A works!?
    RES=$(aws $SVC help | grep -A1000 "$(awsCliFst)" | sed 's/\^H//g')
    COUNT=$(echo -e "$RES" | grep -Ev "$EXCL" | grep -c "$FILT" | awk '{print $1}')

    echo -e "$(jstr -w ${LEFT_WIDTH} "Read-only CLI Command for ${SVC}") Service Actions"
    wline $LINE_WIDTH

    if [ -n "$EXTRA" ]; then
        RES=$(echo -e "$RES" | grep -Ev "$EXCL" | grep "$FILT" | grep -E "$EXTRA")
    else
        RES=$(echo -e "$RES" | grep -Ev "$EXCL" | grep "$FILT")
    fi

    i=0
    while read -r line; do
        [ -z "$line" ] && continue
        i=$(( i + 1 ))
        iStr=$(jstr -r -w 5 "$i")
        line="${line:4}"
        iDebug "Line: $i, $line"
        color=${NC}
        [[ "$line" == 'describe'* ]] && Describe=1 && color="${iGreen}"
        [[ "$line" == 'get'* ]] && Get=1 && color="${iGreen}"
        [[ "$line" == 'list'* ]] && List=1 && color="${iGreen}"

        # Get IAM Actions
        ACTION=$(cli2iam $SVC $line)
        echo -e "${iStr}. ${color}$(jstr -w ${WIDTH} ${line})${NC} ${iYellow}${ACTION}${NC}"
    done <<< "$RES"

    wline $LINE_WIDTH
    echo -e "$(jstr -w ${LEFT_WIDTH} "Read-only CLI Command for ${SVC}") Service Actions"

    echo -e "AWS Service      : ${Yellow}${SVC}${NC}"
    echo -e "AWS CLI Version  : ${Yellow}$(aws --version)${NC}"
    echo -e "Selected Actions : ${Yellow}${i}/${COUNT}${NC}"
    echo -e "Filter Criteria  : ${Yellow}$(echo $EXTRA | sed 's/o //g')${NC}"
    echo -e "${iGreen}Read-only actions${NC}"
    wline $LINE_WIDTH

    [ -n "$Describe" ] && echo -e "${iYellow}${aTab} ${SVC}:Describe*${NC}"
    [ -n "$Get" ] && echo -e "${iYellow}${aTab} ${SVC}:Get*${NC}"
    [ -n "$List" ] && echo -e "${iYellow}${aTab} ${SVC}:List*${NC}"
}

function test_aws_cnv() {
    # usage: test-aws-cnv self-test aws service conversions for IAM, Boto3, CLI, & Policy Sid ### 
    local svc sBoto sCli sIam i SIDs WL
    WL=134
    svc='securityhub'
    sBoto='get_administrator_account'
    sCli='get-administrator-account'
    sIam='GetAdministratorAccount'
    SIDs='
    IAM and SCP Policy Sid Builder
    Deny Protected Resources
    Deny Region Management
        Deny Protected Asset Management
    Allow Security Hub to access AWS Config
    Allow Protected Resource Management
    Allow Security Hub to access Security Token Service
    '

    local HEAD_COLS="%-4s %-10s %-60s %-60s\n"
    local ROWS_COLS="%3d. %-10s %-60s %-60s\n"

    echo -e "${Yellow}Service${NC}: ${Green}${svc}${NC}"
    echo -e "   ${Blue}Boto${NC}: ${Green}${sBoto}${NC}"
    echo -e "   ${Blue}CLI ${NC}: ${Green}${sCli}${NC}"
    echo -e "   ${Blue}IAM ${NC}: ${Green}${sIam}${NC}"
    echo
    printf "$HEAD_COLS" "" "Function" "Input" "Output"
    wline $WL
    i=0
    printf "$ROWS_COLS" "$(( ++i ))" "boto2cli" "${sBoto}" "$(boto2cli ${sBoto})"
    printf "$ROWS_COLS" "$(( ++i ))" "boto2iam" "${svc} ${sBoto}" "$(boto2iam ${svc} ${sBoto})"
    printf "$ROWS_COLS" "$(( ++i ))" "cli2boto" "${sCli}" "$(cli2boto ${sCli})"
    printf "$ROWS_COLS" "$(( ++i ))" "cli2iam" "${svc} ${sCli}" "$(cli2iam ${svc} ${sCli})"
    printf "$ROWS_COLS" "$(( ++i ))" "iam2boto" "${sIam}" "$(iam2boto ${sIam})"
    printf "$ROWS_COLS" "$(( ++i ))" "iam2boto" "${svc}:${sIam}" "$(iam2boto ${svc}:${sIam})"
    printf "$ROWS_COLS" "$(( ++i ))" "iam2cli" "${svc}:${sIam}" "$(iam2cli ${svc}:${sIam})"
    while read -r line; do
        [ -z "$line" ] && continue
        printf "$ROWS_COLS" "$(( ++i ))" "camelcase" "${line}" "$(camelcase ${line})"
    done < <(echo -e "$SIDs" | sed 's/^[ \t]*//;s/[ \t]*$//' | grep -v '^$')
    wline $WL

    echo
    echo " Usage:"
    wline $WL
    echo -e " ${Yellow}boto2cli${NC} ${Cyan}get_administrator_account${NC}"
    echo -e " ${Yellow}boto2iam${NC} ${Magenta}securityhub${NC} ${Cyan}get_administrator_account${NC}"
    echo -e " ${Yellow}cli2boto${NC} ${Cyan}get-administrator-account${NC}"
    echo -e " ${Yellow}cli2iam ${NC} ${Magenta}securityhub${NC} ${Cyan}get-administrator-account${NC}"
    echo -e " ${Yellow}iam2boto${NC} ${Cyan}GetAdministratorAccount${NC}"
    echo -e " ${Yellow}iam2boto${NC} ${Magenta}securityhub${NC}:${Cyan}GetAdministratorAccount${NC}"
    echo -e " ${Yellow}iam2cli ${NC} ${Magenta}securityhub${NC}:${Cyan}GetAdministratorAccount${NC}"
    echo -e " ${Yellow}camelcase ${NC} ${Magenta}'$(echo -e "$SIDs" | sed 's/^[ \t]*//;s/[ \t]*$//' | grep -v '^$' | head -1)'${NC}"
    echo -e " echo '${Magenta}$(echo -e "$SIDs" | sed 's/^[ \t]*//;s/[ \t]*$//' | grep -v '^$' | head -1)${NC}' | ${Yellow}camelcase${NC}"

}

function is-awsp-exp() {
    # usage: [ 0 -eq "$(is-awsp-exp ["profile"]) $?" ] && echo "true" || echo "false" # default $AWS_PROFILE ###
    iTrace "Line: $(( ${(%):-%I} - 2 )), ${iYellow}${funcstack[1]}()${NC} ${iCyan}${*}${NC}"
    local AWSP chk exp secs cur_dt cur_ts chk_dt chk_ts is_cur
    iTrace "Current AWS_PROFILE: $AWS_PROFILE"
    [ -z "$1" ] && AWSP="$AWS_PROFILE" || AWSP="$1"
    [ -z "$AWSP" ] && iWarning "AWS_PROFILE is not set!" && return 2
    iTrace "Given AWS_PROFILE: $AWSP"
    chk_dt=$( cat ~/.aws/credentials | grep "\[$AWSP\]" -A7 | grep 'x_security_token_expires' | awk '{print $3}' )
    iTrace "chk_dt: $chk_dt"
    [ -z "$chk_dt" ] && iWarning "Unable to find AWS_PROFILE for [$AWSP]!" && return 2
    chk_ts=$( dt2ts "${chk_dt}" )
    iTrace "chk_ts: $chk_ts"
    cur_dt=$( iso_dt )
    iTrace "cur_dt: $cur_dt"
    cur_ts=$( dt2ts "${cur_dt}" )
    iTrace "cur_ts: $cur_ts"

    [ "$AWSP" = "$AWS_PROFILE" ] && is_cur="${Yellow}Current${NC} " || is_cur=""
    if [ "$cur_ts" -gt "$chk_ts" ]; then
        iWarning "${is_cur}AWS Profile '${Red}${AWS_PROFILE}${NC}' Expired on ${Red}${chk_dt}${NC}'!"
        iTrace "${Red}Expired!${NC}"
        true
        return
    else
        secs=$(( chk_ts - cur_ts ))
        iTrace "secs: $secs"
        exp=$( sec_disp "$secs" )
        iInfo "${is_cur}AWS Profile '${Green}${AWS_PROFILE}${NC}' Expires in '${Yellow}${exp}${NC}'"
        iTrace "${Green}Active${NC}"
        false
        return
    fi
}

function awsp-exp() {
    # usage: returns expiration date of $1 profile ###
    iTrace "Line: $(( ${(%):-%I} - 2 )), ${iYellow}${funcstack[1]}()${NC} ${iCyan}${*}${NC}"
    local chk_dt awsp
    [ -z "$1" ] && awsp="$AWS_PROFILE" || awsp="$1"
    chk_dt=$( cat ~/.aws/credentials | grep "\[$awsp\]" -A7 | grep 'x_security_token_expires' | awk '{print $3}' )
    [ -z "$chk_dt" ] && iWarning "Unable to find AWS_PROFILE ${awsp}'"
    echo "${chk_dt}"
}

function is-expired() {
    # usage: [ 0 -eq "$( is-expired "dt" ) $?" ] && echo "true" || echo "false" ###
    iTrace "Line: $(( ${(%):-%I} - 2 )), ${iYellow}${funcstack[1]}()${NC} ${iCyan}${*}${NC}"
    local cur_dt cur_ts chk_ts
    cur_dt=$( iso_dt )
    cur_ts=$( dt2ts "${cur_dt}" )
    chk_ts=$( dt2ts "${1}" )
    [ "$cur_ts" -gt "$chk_ts" ] && true || false
    return
}

function awsp-sw() {
    # usage: swithcing to AWS_PROFILE form list of profile name in terminal ###
    iTrace "Line: $(( ${(%):-%I} - 2 )), ${iYellow}${funcstack[1]}()${NC} ${iCyan}${*}${NC}"
    # shellcheck disable=SC2155,SC2002
    local AWS_PROFILES=$( cat ~/.aws/credentials | grep '\[.*\]' | sort | tr -d '[]' )
    iTrace "AWS Profiles:\n$AWS_PROFILES"
    ppwide -b '-' "${Green}Current AWS Profile${NC}"
    echo "$AWS_PROFILE"

    local RS
    declare -a RS
    # shellcheck disable=SC2206
    RS=($( echo "Quit ${AWS_PROFILES}" | tr '\n' ' ' ))
    iTrace "RS: ${RS[*]}"
    local PS3='Select a Profile #? '
    iTrace "PS3: $PS3"
    ppwide -b '-' "${Green}Current AWS Profile${NC}"
    select PROFILE in "${RS[@]}"; do
        case $PROFILE in
            "$PROFILE") break ;;
            *) exit ;;
        esac
    done
    if [[ "Quit" != "$PROFILE" && "${AWS_PROFILE}" != "${PROFILE}" && -n "${PROFILE}" ]]; then
        ppwide -b '-' "${Yellow}Switched AWS Profile${NC}"
        export AWS_PROFILE=$PROFILE
    fi

    ppwide -b '-' "${Green}AWS CA Bundle${NC}"
    export AWS_CA_BUNDLE='./aws/dist/awscli/botocore/cacert.pem'
    echo "${AWS_CA_BUNDLE}"
    ppwide -b '-' "${Green}Current AWS Profile${NC}"
    echo "$AWS_PROFILE"
    is-awsp-exp
}

function awsp-set() {
    # usage: Switch to"$1" AWS_PROFILE ###
    iTrace "Line: $(( ${(%):-%I} - 2 )), ${iYellow}${funcstack[1]}()${NC} ${iCyan}${*}${NC}"
    local NEW_AWS_PROFILE expired exp
    NEW_AWS_PROFILE="$1"
    [ -z "$NEW_AWS_PROFILE" ] && iWarning "Missing required 1st arg for AWS Profile Name" && return 2
    ppwide -b '-' "${Green}Current AWS Profile${NC}"
    echo "$AWS_PROFILE"
    expired=$( is-awsp-exp "${NEW_AWS_PROFILE}" )
    if [ 0 -eq "$?" ]; then
        iWarning "AWS_PROFILE '${NEW_AWS_PROFILE}' is Expired!"
        iInfo "usage: sp NEW_AWS_PROFILE"
    else
        exp=$( awsp-exp()$1 )
        iInfo "AWS_PROFILE '${NEW_AWS_PROFILE}' Expires on ${exp}!"
        ppwide -b '-' "${Yellow}Switched AWS Profile${NC}"
        export AWS_PROFILE=$NEW_AWS_PROFILE
        echo "$AWS_PROFILE"
        is-awsp-exp
    fi
}

function awsp-stat() {
    # usage: [-b] list AWS Profiles in terminal. -b for brief ###
    iTrace "Line: $(( ${(%):-%I} - 2 )), ${iYellow}${funcstack[1]}()${NC} ${iCyan}${*}${NC}"
    local PROFILES_DAT PROFILES_LINES PROFILES PROFILE i expired chk exp_dt exp_ts dt_exp profile_str ts
    ts=$(get_ts)
    sDate=$( get_fmtdate -b | awk '{print $2" "$3" "$5}' )
    ppwide -b '-' "${Blue}Available AWS Profiles${NC} on ${Yellow}${sDate}${NC}"
    PROFILES_DAT=$( cat ~/.aws/credentials )
    declare -a PROFILES
    PROFILES=($( echo "${PROFILES_DAT}" | grep '\[.*\]' | sort | tr -d '[]' | tr '\n' ' ' ))
    iDebug "${PROFILES[@]}"

    cur_dt=$( iso_dt -s)
    cur_ts=$( dt2ts "${cur_dt}" )
    iDebug "cur_dt: $cur_dt"
    iDebug "cur_ts: $cur_ts"

    i=0
    for PROFILE in "${PROFILES[@]}"; do
        i=$(( i + 1 ))
        i_str=$( jstr "$i" --right --width 4 )
        exp_dt=$( echo -e "${PROFILES_DAT}" | grep "\[$PROFILE\]" -A 7 | grep 'x_security_token_expires' | awk '{print $3}' )
        [ -z "$exp_dt" ] && exp_dt="Unknown"
        iDebug "${i}. ${PROFILE} Expiration ${exp_dt}"
        [ -n "$1" ] && width=52 || width=40
        profile_str=$( jstr "$PROFILE" --left --width "$width" )
        # [-b] shows brief Expiration of HH:MM:SS 
        [ -n "$1" ] && exp_dt=$( echo "$exp_dt" | tr 'T' ' ' | awk '{print $2}' | tr '-' ' ' | awk '{print $1}' )
        iDebug "cur_ts: $cur_ts"
        iDebug "cur_dt: $cur_dt"
        iDebug "exp_dt: $exp_dt"
        if [ "$cur_dt" > "$exp_dt" ]; then
            echo -e "${i_str}. ${Red}${profile_str}${NC} Expired on ${Red}${exp_dt}${NC}"
        else
            exp_ts=$( dt2ts "${exp_dt}" )
            iTrace "exp_ts: $exp_ts"
            secs=$(( exp_ts - cur_ts ))
            iTrace "secs: $secs"
            exp=$( sec_disp "$secs" "$@" )
            isTrace "Current AWS_PROFILE '${AWS_PROFILE}' Expires in '${exp}'"
            echo -e "${i_str}. ${Green}${profile_str}${NC} Expires on ${Blue}${exp_dt}${NC} in ${exp}"
        fi
    done
    ppwide -b '-' "${Green}Current AWS Profile${NC} on ${Yellow}${sDate}${NC}"
    echo "$AWS_PROFILE"
    is-awsp-exp
    iTrace $(took_ts "$ts")
}

function awsp-detail() {
    # usage: returns list of AWS Profiles ###
    iTrace "Line: $(( ${(%):-%I} - 2 )), ${iYellow}${funcstack[1]}()${NC} ${iCyan}${*}${NC}"
    local PROFILES_DAT LINE

    PROFILES_DAT=$(cat ~/.aws/credentials | grep -A8 "^\[.*\]" | grep "\[.*\]\|x_security_token_expires\|x_principal_arn\|region\|^$")

    echo -e "$PROFILES_DAT" |
    while IFS= read -r LINE; do
        if [ '[' = "${LINE:0:1}" ]; then
            echo -e "${Yellow}${LINE}${NC}"
        elif [[ "${LINE}" == *"x_security_token_expires"* ]]; then
            exp=$( echo "$LINE" | awk '{print $3}' )
            if [ 0 -eq "$( is-expired $exp ) $?" ]; then
                echo -e "${Red}${LINE}${NC}"
            else
                echo -e "${Green}${LINE}${NC}"
            fi
        else
            echo -e "${LINE}"
        fi
    done
    echo -e "\nLegends: ${Yellow}[Profile]${NC}, ${Red}Expired${NC}, ${Green}Active${NC}"
}

function awspl() {
    # usage: returns list of AWS Profiles ###
    [ 'bash' = "${MY_SHELL}" ] && iTrace "Line: $(func_lineno ${FUNCNAME[0]} 2), ${iYellow}${FUNCNAME[0]}()${NC} ${iCyan}${*}${NC}"
    [ 'zsh'  = "${MY_SHELL}" ] && iTrace "Line: $(( ${(%):-%I} - 3 )), ${iYellow}${funcstack[1]}()${NC} ${iCyan}${*}${NC}"
    cat ~/.aws/credentials | grep "^\[.*\]"
}

## CloudFormation
function cfn-lint-dir() {
    # usage: cfn-llint-dir "$path" all files in form of ls 1 "$path" ###
    res=$(ls 1 "$1")
    while read -r line; do
        [ ! -f "$line" ] && iWarning "Not a valid CloudFormation file: $line" && continue
        ppwide "CloudFormation Lint for: $line"
        cfn-lint "$line"
    done < <(printf '%s\n' "$res")
}

function cfn-ref() {
    # usage: returns cloudformation function references for given json or yaml file ###
    local REFS filt FILT ref fuunc file res count
    # CloudFormation Intrinssic function reefereence
    # https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/intrinsic-function-reference.html
    REFS='
    Fn::Base64
    Fn::Cidr

    # Conditions
    Fn::And
    Fn::Equals
    Fn::If
    Fn::Not
    Fn::Or

    Fn::FindInMap
    Fn::ForEach
    Fn::GetAtt
    Fn::GetAZs
    Fn::ImportValue
    Fn::Join
    Fn::Length
    Fn::Select
    Fn::Split
    Fn::Sub
    Fn::ToJsonString
    Fn::Transform
    Ref
    '

    iTrace "Processing Intrinsic Fucntions"
    FILT=''
    while read -r func; do
        func=$( echo $func | awk '{print $1}' ) # trim whitespace

        # skip empty & comment
        [ -z "$func" ] && continue
        [ '#' = "${func:0:1}" ] && continue

        data="${func}"
        func=$(echo "$func" | tr ':' ' ' | awk '{print $NF}')
        if [ 'Fn::' = "${data:0:4}" ]; then
            filt="!${func}|\"Fn::${func}\""
        else
            filt="!${func}|\"${func}\""
        fi
        iDebug "$(jstr -l -w 20 ${data}) ${filt}"  # function filter
        [ -z "$FILT" ] && FILT="$filt" || FILT="${FILT}|${filt}"
    done < <(printf '%s\n' "$REFS")
    iDebug "FILT: ${FILT}"  # final filter

    file="$1"
    [ ! -f "$file" ] && iCrirical "Unable to read given file: $file"

    ppwide "${Orange}Filter Interinsic Fucntion${NC}"
    cat $file | grep -B 2 -E $FILT
    wline
    echo -e "${Yellow}Input File   ${NC}: ${Orange}${file}${NC}"
    echo -e "${Yellow}Total Matches${NC}: ${Orange}$(cat $file | grep -E $FILT | grep -c '^')${NC}"
}

function cfn-rules() {
    # usage: list formated cfn-lint --list-rules ###
    # requires pip install cfn-lint
    local res i line tab color code
    res=$(cfn-lint --list-rules)

    tab='    '
    i=0
    while read -r line; do
        [ -z "$line" ] && continue
        if [ ':' = "${line:5:1}" ]; then
            i=$(( i + 1 ))
            [ 'E' = "${line:0:1}" ] && color="${Red}" || color="${Orange}"

            echo -e "$(jstr -r -w 4 ${i}). ${color}${line:0:5}${NC}: ${Yellow}${line:7}${NC}"
        else
            echo -e "${tab}${tab}${line}"
        fi
    done < <(printf '%s\n' "$res")
}

# UNITTEST
function test_case() {
    # usage: printstest case for camel, snake, spinal case conversion ###
    local spinal snake camel i 
    spinal="input-text-to-test-different-cases"
    snake="input_text_to_test_different_cases"
    camel="InputTextToTestDifferentCases"

    iTrace "snake_case  : $snake"
    iTrace "spinal-case : $spinal"
    iTrace "CamelCase   : $camel"

    i=0
    local HEAD_COLS="%-3s %-12s %-38s %-38s\n"
    local ROWS_COLS="%3d %-12s %-38s %-38s\n"

    printf "$HEAD_COLS" "" "Function" "Input" "Output"
    wline 
    printf "$ROWS_COLS" "$(( ++i ))" "camel2snake"  "${camel}" "$(camel2snake ${camel})"
    printf "$ROWS_COLS" "$(( ++i ))" "camel2spinal" "${camel}" "$(camel2spinal ${camel})"
    printf "$ROWS_COLS" "$(( ++i ))" "snake2camel"  "${snake}" "$(snake2camel ${snake})"
    printf "$ROWS_COLS" "$(( ++i ))" "spinal2camel" "${spinal}" "$(spinal2camel ${spinal})"
    wline 
}

## Conversion
function yaml2json() {
    # usage: yaml2json file.yaml or yaml data from stdin ###
    local file="$1"
    [ -e "$file" ] && cat "$file" | $PY -c 'import sys, yaml, json; from yaml import SafeLoader;json.dump(yaml.load(sys.stdin, Loader=SafeLoader), sys.stdout, indent=2)'
    [ ! -e "$file" ] && $PY -c 'import sys, yaml, json; from yaml import SafeLoader;json.dump(yaml.load(sys.stdin, Loader=SafeLoader), sys.stdout, indent=2)'
}

function json2yaml() {
    # usage: json2yaml file.json or json data from stdin ###
    local file="$1"
    [ -e "$file" ] && cat "$file" | $PY -c 'import sys, yaml, json; yaml.safe_dump(json.load(sys.stdin), sys.stdout, default_flow_style=False)'
    [ ! -e "$file" ] && $PY -c 'import sys, yaml, json; yaml.safe_dump(json.load(sys.stdin), sys.stdout, default_flow_style=False)'
}

# PS1 Args
# %d – Current date
# %t – Current time
# %h – Host name
# %# – Command number
# %u – User name
# %W – Current working directory (i.e: Desktop/)
# %w – Current working directory, full path (i.e: /Users/Admin/Desktop)
[ 'zsh'  = "${MY_SHELL}" ] && autoload -U colors && colors
PS1="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg[yellow]%}%~ %{$reset_color%}%% "

# PS1="%n@%m %1~ %# " # Original

# https://ohmyposh.dev/docs/installation/prompt
if [ -n "$ZSH_VERSION" ]; then
    # eval "$(oh-my-posh init zsh --config ~/config.omp.json)"
    eval "$(oh-my-posh init zsh --config ~/config.omp.json)"
    # https://github.com/ryanoasis/nerd-fonts#option-6-ad-hoc-curl-download
else
    eval "$(oh-my-posh init bash --config ~/config.omp.json)"
    # eval "$(oh-my-posh init bash --config ~/jandedobbeleer.omp.json)"
fi

## Keys
export OPENAI_API_KEY="$(cat $HOME/www/.OPENAI_API_KEY)"