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
    local from=$2
    local to=$3
    echo ${text/$from/$to}
}

function read_file() {
    local version_pattern='([[:digit:]]+\.)+(([[:digit:]]+)|(\w+))(-\w+)*(\.jar$)|([[:digit:]]+\.jar$)'
    local snapshot="-SNAPSHOT"
    local resultError=""
    
    cat $1 | while read line; do
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

        local findResult=$(find /home/felipe/Downloads/teste/ -name $name)

        if check_version $findResult $version; then
            echo "Achou. - $name - $version"
        else
            echo "Não achou - $name - $version"
        fi
    done
}

function has_version() {
    local argsCountMinusVersion=$(($#-1))
    local allArgsButTheLast=${@:1:$argsCountMinusVersion}
    local version="${!#}"
    
    if [[ $argsCountMinusVersion == 1 ]]; then
        if [[ $1 == $version ]]; then
            return 0
        else
            return 1
        fi
    else
        for argVersion in $@; do
            if [[ $argVersion == $version ]]; then
                return 0
            fi
        done

        return 1
    fi
}

function check_version() {
    local argsCountMinusVersion=$(($#-1))
    local version="${!#}"

    if [[ $argsCountMinusVersion == 0 ]]; then
        return 1
    fi

    local allArgsButTheLast=${@:1:$argsCountMinusVersion}
    local hasVersion=1

    for findCommand in $allArgsButTheLast; do
        local resultListCommand=$(ls $findCommand)

        if has_version $resultListCommand $version; then
            return 0
        fi
    done

    return 1
}