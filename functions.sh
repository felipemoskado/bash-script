function exists_file() {
    if [ -e $1 ]; then
        return 0
    else 
        return 1
    fi
}

function get_string_until() {
    local text=$1
    local untilString=$2
    echo ${text%$untilString*}
}

function contains() {
    local text=$1
    local condition=$2

    if [[ $text == *"-SNAPSHOT"* ]]; then
        return 0
    else
        return 1
    fi
}

function replace() {
    local text=$1
    local replacementFrom=$2
    local replacementTo=$3
    echo ${text/$replacementFrom/$replacementTo}
}

function read_file() {
    local snapshot="-SNAPSHOT"
    while read line; do 
        line=$(get_string_until $line .jar)

        if contains $line $snapshot; then
            line=$(replace $line $snapshot "")
            echo $line
        fi
    done < $1
}