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
    local version_pattern='([[:digit:]]+\.)+(([[:digit:]]+)|(\w+))(-\w+)*(\.jar$)|([[:digit:]]+\.jar$)'
    local snapshot="-SNAPSHOT"
    local resultError=""
    
    while read line; do 
        local version=""
        local name=""
        line=$(get_string_until $line :)

        if contains $line $snapshot; then
            line=$(replace $line $snapshot "")
        fi

        if [[ $line =~ $version_pattern ]]; then
            version=$(replace $BASH_REMATCH .jar)
            name=$(replace $line "-$BASH_REMATCH" "")
        else
            resultError="${resultError}line=$line / name=$name / version=$version \\n"
        fi

        test $(find /home/felipe/Downloads/teste/ -name $name)
    done < $1

    echo -e $resultError >> result-error.txt
}

function test() {
    
    echo $#
}
