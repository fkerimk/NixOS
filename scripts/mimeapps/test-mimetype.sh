#!/usr/bin/env fish

set file_path (zenity --file-selection --title="Select a file")

if test -z "$file_path"; exit 1; end

set mimetype (python3 -c "
import mimetypes
file_path = '$file_path'
mimetype, encoding = mimetypes.guess_type(file_path)
print(mimetype)
")

# Sonucu gösteriyoruz
if test -z "$mimetype"
    zenity --error --text="NULL"
else
    zenity --info --text="Copied to clipboard" --title=$mimetype
    echo $mimetype | wl-copy
end
