#!/bin/bash
if [ ! -r "index.txt.asc" ] && [ ! -w "index.txt" ];
then
    touch "index.txt"
fi

if [ -r "index.txt.asc" ] && [ ! -w "index.txt" ];
then
    gpg -v "index.txt.asc"
fi

if [ -w "index.txt" ];
then
    UUID=$(uuidgen)
    echo "$UUID $(date +"%Y%m%d%H%M%S") " >> "index.txt"
    touch "$UUID".txt
fi
