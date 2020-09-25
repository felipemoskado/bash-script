#!/bin/bash

BASE_DIR="/home/felipe/Downloads/teste"
CHANGE_FILE="$BASE_DIR/patch-10.14b84/changed_files.txt"

#Lê o arquivo
while read line; do 
    echo line

done < $CHANGE_FILE
