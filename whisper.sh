#!/bin/bash
DO=${1}
FRP="422b779cd894982bc41e85ee3624cad78afc3169"
echo $DO

if [ "$DO" == "new" ];
then
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
elif [ "$DO" == "enc" ]; then
    for i in $(find . -name "*.txt");do
        gpg -vae --yes -r $FRP $i
        rm -rf $i
    done
fi
