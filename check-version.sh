#!/bin/bash

BASE_DIR="/home/felipe/Downloads/teste"
CHANGE_FILE="$BASE_DIR/patch-10.14b84/changed_files.txt"

if [ ! -e $CHANGE_FILE ]
then
    echo "Arquivo inexistente."
fi

#Lê o arquivo
while read line; do
    #Remove todos caracteres após o ".jar"
    line=${line%.jar*}
done < $CHANGE_FILE
