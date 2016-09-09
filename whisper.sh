#!/bin/bash
DO=${1}
FRP="422b779cd894982bc41e85ee3624cad78afc3169"

if [ "$DO" == "new" ];
then
    if [ ! -r "index.txt.asc" ] && [ ! -w "index.txt" ];
    then
        echo -e '\033[1;33m!: Create `index.txt`\033[0m'
        touch "index.txt"
    fi

    if [ -r "index.txt.asc" ] && [ ! -w "index.txt" ];
    then
        echo -e '\033[1;33m!: Decrypt `index.txt`\033[0m'
        gpg -v "index.txt.asc"
    fi

    if [ -w "index.txt" ];
    then
        UUID=$(uuidgen)
        echo -e "\033[1;33m!: Insert record into 'index.txt' ($UUID)\033[0m"
        echo "$UUID $(date +"%FT%T%z") " >> "index.txt"
        touch "$UUID".txt
    fi
elif [ "$DO" == "e" ]; then
    echo -e '\033[1;33m!: Encrypt all.\033[0m'
    for i in $(find . -name "*.txt" -maxdepth 1);do
        gpg -vae --yes -r $FRP $i
        rm -rf $i
    done

    if [ ! -d "deep" ];
    then
        echo -e "\033[1;33m!: Create 'deep'\033[0m"
        mkdir "deep"
    fi

    for i in $(find . -name "*.txt.asc" -maxdepth 1);do
        if [ ! "$i" == "./index.txt.asc" ];
        then
            echo -e "\033[1;33m!: Move $i into 'deep'\033[0m"
            mv $i ./deep
        fi
    done
elif [ "$DO" == "env" ]; then
    gpg -k "$FRP"
else
    echo "Usage: ./whisper.sh [command]"
    echo ""
    echo "Commands:"
    echo "  new  Create an new txt"
    echo "  e    Encrypt all txt"
    echo "  env  Show user key info"
fi
