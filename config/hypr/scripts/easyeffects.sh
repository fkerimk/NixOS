#!/usr/bin/env fish

# Start easyeffects if it's not already running
if not pgrep -x "easyeffects" > /dev/null
    easyeffects &
end

# Wait for easyeffects to start
while not pgrep -x "easyeffects" > /dev/null
    sleep 1
end

# Hide the window if needed
easyeffects --hide-window &
