#!/bin/bash
DO=${1}
FRP="422b779cd894982bc41e85ee3624cad78afc3169"

if [ "$DO" == "new" ];
then
    if [ ! -r "index.txt.asc" ] && [ ! -w "index.txt" ];
    then
        echo '!: Create `index.txt`'
        touch "index.txt"
    fi

    if [ -r "index.txt.asc" ] && [ ! -w "index.txt" ];
    then
        echo '!: Decrypt `index.txt`'
        gpg -v "index.txt.asc"
    fi

    if [ -w "index.txt" ];
    then
        UUID=$(uuidgen)
        echo "!: Insert record into 'index.txt' ($UUID)"
        echo "$UUID $(date +"%Y%m%d%H%M%S") " >> "index.txt"
        touch "$UUID".txt
    fi
elif [ "$DO" == "e" ]; then
    echo '!: Encrypt all.'
    for i in $(find . -name "*.txt" -maxdepth 1);do
        gpg -vae --yes -r $FRP $i
        rm -rf $i
    done

    if [ ! -d "deep" ];
    then
        echo "!: Create 'deep'"
        mkdir "deep"
    fi

    for i in $(find . -name "*.txt.asc" -maxdepth 1);do
        if [ ! "$i" == "./index.txt.asc" ];
        then
            echo "!: Move $i into 'deep'"
            mv $i ./deep
        fi
    done
else
    echo "whisper [cmd]"
    echo "  cmd:"
    echo "   - new: Create an new txt"
    echo "   - e: encrypt all txt"
fi
