#!/usr/bin/env bash

dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
usr=$(eval echo "~$SUDO_USER")
nix="$usr/NixOS"
tmp="$dir/temp"

cache="$tmp/cache"

if ! [ -d "$cache" ]; then
    mkdir $cache; tar -xzf "$dir/database.tar.gz" -C "$cache/"
fi

if [ "$1" = 'init' ]; then exit; fi

MARKUP_WORD='<i><span fgcolor=\"#E48F45\">$data$on_suffix $origin_id</span></i>' 
MARKUP_MEANING='<b>$meaning_id.</b><span fgcolor=\"red\"><i>$features</i></span> $data' 
MARKUP_EXAMPLE='<span>$data</span> <i>$writer</i>' 

runrofi () {
    $(command -v rofi) -sorting-method fzf -sort true -normalize-match "$@"
}

meaning () {
    if [ -n "$1" ]; then 
        hash=$(echo -ne "$1" | md5sum | cut -c -32)
        if ! [ -f "$cache/$hash" ]; then
            echo -e "error\nKelime bulunamadı." > $tmpmf
        else
            echo -e "word\n$hash" > $tmpmf
        fi
    fi
}


export tmpmf=$(mktemp "$tmp/rofi-tdk.XXXXXXXX")
echo -ne 'start' > $tmpmf

while true; do
    fl=$(cat $tmpmf | head -n 1)
    data=$(cat $tmpmf | tail -n +2)

    case $(echo ${fl//[$'\t\r\n']} | head -n 1) in
        start) 
            word=$(cat $cache/list | runrofi -dmenu -p "TDK")
            echo -ne 'exit' > $tmpmf
            meaning "$word"
            
        ;;error)
            runrofi -e "$data"
            echo "start" > $tmpmf

        ;;line) 
            tmpf=$(mktemp "$tmp/rofi-tdk-line.XXXXXXXX")
            echo -ne "Geri" > $tmpf
            details=$(echo "$data" | sed -n 3p) 
            if [ -n "$details" ]; then 
                echo "|$details" >> $tmpf
                mesg=; sentence=
            else 
                mesg='-mesg'; sentence="$(echo "$data" | sed -n 2p)"
            fi
            line=$(cat $tmpf | runrofi -dmenu $mesg "$sentence" -markup-rows -p 'TDK' -sep '|')
            if [ "$line" = "Geri" ] || [ -z "$line" ]; then
                echo -e "word\n$(echo "$data" | sed -n 1p)" > $tmpmf
            else
                meaning "$line"
            fi
            rm $tmpf

        ;;word) 
            tmpf=$(mktemp "$tmp/rofi-tdk-word.XXXXXXXX")
            details=$(mktemp "$tmp/rofi-tdk-details.XXXXXXXX")
            hash=$data
            data=$(cat "$cache/$hash")

            echotmp () {
                echo $@ >> $tmpf
                if [[ "$(tail -c 1 $tmpf | od -An -t x1)" == ' 0a' ]]; then echo '' >> $details; fi
            }
            echodetails () { echo -n $@ >> $details; }

            echotmp ''
            meaning_id=1; writer=; features=; on_suffix=; origin_id=
            echo "$data" | while read line; do 
                type=$(echo $line | cut -c 1)
                data=$(echo $line | cut -c 2-)
                if [ -z "$data" ]; then data=$(echo $line | sed -n 's/^\s*\w\s\+\(.*\)$/\1/p'); fi
                case $type in
                    'm') 
                        echotmp "$(eval "echo \"$MARKUP_WORD\"")"
                        on_suffix=; origin_id=
                    ;;'a')
                        w343="$(echo $data | sed 's/^343\ //g; s/^► //g; s/([IV]*)$//g')"
                        if [[ "$data" == "343 "* ]] || [[ "$data" == "► "* ]]; then 
                            echodetails $w343
                        fi
                        data=$(echo $data | sed 's/^343\ /<i>bakınız<\/i> /')
                        echotmp -e "$(eval "echo \"$MARKUP_MEANING\"")"
                        ((meaning_id ++)); features=
                    ;;'o') 
                        echotmp -e "$(eval "echo \"$MARKUP_EXAMPLE\"")"
                        writer=
                    ;;'y') writer="- $data"
                    ;;'k') origin_id="($data)"
                    ;;'z') features=" $data"
                    ;;'t') if [ -n "$data" ]; then on_suffix=", -$data"; fi
                    ;;'b') 
                        if [ -n "$data" ]; then
                            echodetails $(echo "$data" | sed 's/, /|/g')
                            echotmp "Birleşik isimler: $data"
                        fi
                    ;;'s') 
                        echodetails "$data"
                        echotmp "Kalıp sözler: $(echo "$data" | sed 's/|/, /g')"
                    ;;'') echotmp ''; meaning_id=1
                    ;;*) if [ -n "$data" ]; then echotmp "$data"; fi
                esac
            done

            selected=$(cat $tmpf | rofi -p 'TDK' -dmenu -markup-rows -format "d:s")
            line=$(echo "$selected" | sed 's/^\([[:digit:]]\+\):.*$/\1/')
            markup=$(echo "$selected" | cut -c $((${#line} + 2))-)

            if [ -z "$line" ]; then echo -ne 'start' > $tmpmf
            elif [ -z "$markup" ]; then exit 0;
            else
                linedetails="$(cat $details | sed -n ${line}p)"
                if ! [[ "$linedetails" == *'|'* ]] && [ -n "$linedetails" ]; then
                    meaning "$linedetails"
                else 
                    echo -ne "line\n$hash\n$markup\n$linedetails" > $tmpmf
                fi
            fi
            rm $tmpf $details

        ;;*) 
            rm $tmpmf; exit
    esac
done
