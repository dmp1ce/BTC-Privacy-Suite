#!/bin/bash

continueYN() {
    read -r -p "Continue (y/n)?" choice
    case "$choice" in
        y|Y ) ;;
        * ) echo "Exiting"; exit 0;;
    esac
}
