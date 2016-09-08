#!/bin/bash

for i in $(find . -name "*.txt");do
    gpg -vae --yes -r 422b779cd894982bc41e85ee3624cad78afc3169 $i
    rm -rf $i
done
