#!/usr/bin/env bash

dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

while getopts "f:m:ulcp:h" opt; do
    case ${opt} in
        f) font="$OPTARG" ;;
        m) message="$OPTARG" ;;
        u) uppercase=true; lowercase=false ;;
        l) lowercase=true; uppercase=false ;;
        c) clipboard=true ;;
        p) prefix=$OPTARG ;;
        h)
            echo "-f <font>" 
            echo "-m <message>" 
            echo "-p <prefix>" 
            echo "-u : uppercase" 
            echo "-l : lowercase" 
            echo "-c : copy to clipboard" 
            exit 1 ;;
        \?) exit 1 ;;
        :) exit 1 ;;
    esac
done

if [[ -z "$font" ]]; then font=$(find $dir/fonts/ -name "*.flf" -exec basename {} .flf \; | fzf); fi
if [[ -z "$message" ]]; then message=$font; fi

if [ "$uppercase" = "true" ]; then message=$(LC_ALL=C tr '[:lower:]' '[:upper:]' <<< "$message"); fi
if [ "$lowercase" = "true" ]; then message=$(LC_ALL=C tr '[:upper:]' '[:lower:]' <<< "$message"); fi

output=$(figlet -f "$dir/fonts/$font.flf" "$message" | awk 'NF > 0')

if [[ -n "$prefix" ]]; then output=$(echo "$output" | sed "s|^|$prefix |" ); fi

echo "$output" | lolcat

if [[ -n "$clipboard" ]]; then echo "$output" | wl-copy; fi
    
