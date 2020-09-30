#!/bin/bash
# https://devhints.io/bash

BASE_DIR="/home/felipe/Downloads/teste"
CHANGE_FILE="$BASE_DIR/patch-10.14b84/changed_files.txt"

source functions.sh

function run() {
    if ! exists_file $CHANGE_FILE; then
        echo "Arquivo não existe"
        return
    fi
    
    process_file $CHANGE_FILE
}

run