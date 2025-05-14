#dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
#usr=$(eval echo "~$SUDO_USER")
#nix="$(eval echo "~$SUDO_USER")/NixOS"
#tmp="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/temp"

reload () {

    $(eval echo "~$SUDO_USER")/NixOS/reload.sh "$@"
}

figlett (){

    $(eval echo "~$SUDO_USER")/NixOS/scripts/figlett/figlett.sh "$@"
}

#date +"%d.%m - %H:%M" | figlet | lolcat -f | boxes -d tux