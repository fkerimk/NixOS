#!/usr/bin/env fish

set temp ~/.config/scripts/mimeapps/temp

set mimeapps_source ~/.config/scripts/mimeapps/mimeapps.list
set mimeapps_target ~/.config/mimeapps.list

set mimetypes_target ~/.local/share/mime/packages/custom-mimetypes.xml

#set register_mimes null
#set register_mimetypes null

# ▖▖▄▖▄▖▄▖▄▖▄ ▖ ▄▖▄▖
# ▌▌▌▌▙▘▐ ▌▌▙▘▌ ▙▖▚
# ▚▘▛▌▌▌▟▖▛▌▙▘▙▖▙▖▄▌

set archive 'mime.archive.desktop'
set code    'mime.code.desktop'
set folder  'mime.folder.desktop'
set image   'mime.image.desktop'
set text    'mime.text.desktop'
set video   'mime.video.desktop'
set web     'mime.web.desktop'

set vars archive code folder image text video web

# Write mimeapps.list

function write_mime_apps
    for line in (cat $mimeapps_source)

        #if string match -r '^#' $line > /dev/null 2>&1
            #if string match -r '^#~' $line > /dev/null 2>&1
            #    set register_mimes (string sub -s 2 -- (string trim -- $line))
            #    set register_mimetypes null
            #    if not test "$register_mimes" = "~null"
            #        set register_mimes (string replace -a '~' '/home/fkerimk' $register_mimes)
            #    else
            #        set register_mimes null
            #    end
            #end
            #continue;
        #end

        #if test (string trim $line) = "" ;continue;end

#       #if not test "$register_mimes" = null
#
#            set mimetype (string split "=" $line)[1]
#
#            echo '[Desktop Entry]' > $temp
#
#            for mimeline in (cat $register_mimes)
#
#                if string match -r '^\[Desktop Entry\]' $mimeline > /dev/null 2>&1 ;continue;end
#                if test (string trim $mimeline) = "" ;continue;end
#
#                if test (string trim $mimeline) = "MimeType=" 
#                
#                    echo "MimeType=$register_mimetypes" >> $temp
#
#                    continue
#                end
#
#                set mimeline (string replace -a 'a' 'b' -- "$mimeline")
#                echo "$mimeline" >> $temp
#            end
#
#            mv update_temp $register_mimes
#       end

        for var in $vars
            set val (eval echo \$$var)
            set line (string replace -a "\$$var" "$val" -- $line)
        end

        echo $line >> $mimeapps_target

    end
end

echo '[Default Applications]' > $mimeapps_target
write_mime_apps
echo '' >> $mimeapps_target
echo '[Added Associations]' >> $mimeapps_target
write_mime_apps

# Write custom-mimetypes.xml
function write_mime_type
    echo "    <mime-type type=\"$argv[2]\">" >> $mimetypes_target
    echo "        <comment>$argv[1]</comment>" >> $mimetypes_target
    for filetype in (string split ", " $argv[3])
        echo "        <glob pattern=\"*.$filetype\"/>" >> $mimetypes_target
    end
    echo "    </mime-type>" >> $mimetypes_target
end

echo '<?xml version="1.0" encoding="UTF-8"?>' > $mimetypes_target
echo '<mime-info xmlns="http://www.freedesktop.org/standards/shared-mime-info">' >> $mimetypes_target

# ▄▖▖▖▄▖▄▖▄▖▖  ▖  ▄▖▖▖▄▖▄▖▄▖
# ▌ ▌▌▚ ▐ ▌▌▛▖▞▌  ▐ ▌▌▙▌▙▖▚
# ▙▖▙▌▄▌▐ ▙▌▌▝ ▌  ▐ ▐ ▌ ▙▖▄▌

write_mime_type "Code" application/x-code "list, conf"

# Finish custom-mimetypes.xml
echo '</mime-info>' >> $mimetypes_target

# ▄▖▄▖▖▖▄▖▄▖  ▄▖▄▖▖▖▄▖▄▖
# ▌▌▐ ▙▌▙▖▙▘  ▚ ▐ ▌▌▙▖▙▖
# ▙▌▐ ▌▌▙▖▌▌  ▄▌▐ ▙▌▌ ▌

# Update
update-desktop-database ~/.local/share/mime/packages
update-desktop-database ~/.local/share/applications
update-desktop-database ~/.config
update-desktop-database

update-mime-database ~/.local/share/mime
update-mime-database

# Notify
zenity --info --text='İşlem başarılı!' --title='Başarı'