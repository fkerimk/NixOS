#!/usr/bin/env fish

if test (count $argv) -gt 0

    set chosen $argv[1]

    switch $chosen

        case "📚 TDK"   ; nohup .config/rofi/scripts/rofi-tdk/rofi-tdk.sh > /dev/null 2>&1 &
        case "📶 WiFi"  ; nohup .config/rofi/scripts/rofi-wifi-menu.sh > /dev/null 2>&1 &
        case "🧩 Run"   ; nohup rofi -show drun -modi drun > /dev/null 2>&1 &
        case "⚙️ Config"; nohup code .config/ 2>&1 &
        case "♻️ Reboot"; reboot

        case "*"; exit
    end
    
    exit
end

echo "🧩 Run"
echo "🧰 Unity"
echo "⚙️ Config"
echo "♻️ Reboot"
echo "📶 WiFi"
echo "📚 TDK"