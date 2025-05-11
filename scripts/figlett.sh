#!/usr/bin/env fish

set fonts (ls -1 /usr/share/figlet/fonts/*.flf | xargs -n 1 basename | sed 's/.flf$//')

set font (for font in $fonts
    echo $font
end | sed 's/\x1b\[[0-9;]*m//g' | fzf --prompt="Font Seç:")

# Eğer bir font seçildiyse, figlet ile yazıyı renderla
if test -n "$font"

    if test (count $argv) -gt 0
        set text $argv
    else
        set text $font
    end

    figlet -f "/usr/share/figlet/fonts/$font.flf" $text | lolcat

    echo figlet -f \"/usr/share/figlet/fonts/$font.flf\" $text
else
    echo "Font seçilmedi!"
end
