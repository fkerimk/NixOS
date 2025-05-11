#!/usr/bin/env fish

set CHEAT_SHEET "$HOME/.config/nerd-fonts/cheat-sheet.md"

if not test -f $CHEAT_SHEET
    notify-send "Nerd Font Picker" "Cheat sheet bulunamadı: $CHEAT_SHEET"
    exit 1
end

# Fish için çıktıyı set ile almak
set ICONS (grep -E "nf-[a-z0-9\-]+\s+.+$" $CHEAT_SHEET | sed 's/^/ /')

set CHOICE (echo $ICONS | rofi -dmenu -p "⌨ Nerd Font Icon Seç")

if test -n "$CHOICE"
    set ICON (echo $CHOICE | awk '{print $3}')
    echo -n $ICON | xclip -selection clipboard
    notify-send "Nerd Icon Seçildi" "'$ICON' panoya kopyalandı! ✨"
end
