#ls /run/current-system/sw/share/applications/

{ config, lib, pkgs, ... }:

let

    # ▄▖▄▖▄▖▖▖▄▖▖▖▄▖
    # ▌▌▙▘▌ ▙▌▐ ▌▌▙▖
    # ▛▌▌▌▙▖▌▌▟▖▚▘▙▖

    archive-app = "org.gnome.FileRoller.desktop";

    archive-types = [
        
        "application/zip"
        "application/gzip"
        "application/zstd"
        "application/vnd.rar"
        "application/vnd.ms-cab-compressed"

        "application/x-xz"
        "application/x-tzo"
        "application/x-lha"
        "application/x-rar"
        "application/x-tar"
        "application/x-xar"
        "application/x-lzma"
        "application/x-tarz"
        "application/x-cpio"
        "application/x-bzip"
        "application/x-archive"
        "application/x-cd-image"
        "application/x-compress"
        "application/x-source-rpm"
        "application/x-7z-compressed"
        "application/x-compressed-tar"
        "application/x-cpio-compressed"
        "application/x-iso9660-appimage"
        "application/x-xz-compressed-tar"
        "application/x-lz4-compressed-tar"
        "application/x-bzip-compressed-tar"
        "application/x-lzip-compressed-tar"
        "application/x-lzma-compressed-tar"
        "application/x-zstd-compressed-tar"
        "application/x-lrzip-compressed-tar"
        "application/x-bzip2-compressed-tar"
    ];

    # ▄▖▄▖▄ ▄▖
    # ▌ ▌▌▌▌▙▖
    # ▙▖▙▌▙▘▙▖

    code-app = "vscode-patched.desktop";

    code-types = [

        "application/xhtml+xml"
        "application/x-sh"
        "application/x-shellscript"
        "application/x-extension-xhtml"
    ];

    # ▄▖▄▖▖ ▄ ▄▖▄▖
    # ▙▖▌▌▌ ▌▌▙▖▙▘
    # ▌ ▙▌▙▖▙▘▙▖▌▌

    folder-app = "nemo.desktop";

    folder-types = [

        "inode/directory"
        "inode/mount-point"
        "application/folder"
        "application/x-folder"
        "application/x-directory"
        "x-directory/normal"
        "x-directory/gnome-default-handler"
        "x-scheme-handler/trash"
    ];

    # ▄▖▖  ▖▄▖▄▖▄▖
    # ▐ ▛▖▞▌▌▌▌ ▙▖
    # ▟▖▌▝ ▌▛▌▙▌▙▖

    image-app = "com.github.weclaw1.ImageRoll.desktop";

    image-types = [

        "image/png"
    ];

    # ▄▖▄▖▄▖▖  ▖▄▖▖ ▖▄▖▖ 
    # ▐ ▙▖▙▘▛▖▞▌▐ ▛▖▌▌▌▌ 
    # ▐ ▙▖▌▌▌▝ ▌▟▖▌▝▌▛▌▙▖

    terminal-app = "alacritty.desktop";

    terminal-types = [

        "x-scheme-handler/terminal"
    ];

    # ▄▖▄▖▖▖▄▖
    # ▐ ▙▖▚▘▐
    # ▐ ▙▖▌▌▐

    text-app = "textadept.desktop";

    text-types = [

        "text/plain"
    ];

    # ▖▖▄▖▄ ▄▖▄▖
    # ▌▌▐ ▌▌▙▖▌▌
    # ▚▘▟▖▙▘▙▖▙▌

    video-app = "mpv.desktop";

    video-types = [

        "video/mp4"
        "video/quicktime"
        "video/x-matroska"
    ];

    # ▖  ▖▄▖▄
    # ▌▞▖▌▙▖▙▘
    # ▛ ▝▌▙▖▙▘

    web-app = "zen-patched.desktop";

    web-types = [

        "text/html"
        "application/pdf"
        "application/x-extension-xht"
        "application/x-extension-htm"
        "application/x-extension-html"
        "application/x-extension-shtml"
        "x-scheme-handler/http"
        "x-scheme-handler/https"
        "x-scheme-handler/chrome"
    ];

    mkAssoc = desktop: types: lib.listToAttrs (map (type: { name = type; value = [ desktop ]; }) types);
in

{
    xdg.mime = {

        enable = true;

        defaultApplications = lib.mkMerge [

            (mkAssoc archive-app archive-types)
            (mkAssoc code-app code-types)
            (mkAssoc folder-app folder-types)
            (mkAssoc image-app image-types)
            (mkAssoc terminal-app terminal-types)
            (mkAssoc text-app text-types)
            (mkAssoc video-app video-types)
            (mkAssoc web-app web-types)
        ];

        addedAssociations = lib.mkMerge [

            (mkAssoc archive-app archive-types)
            (mkAssoc code-app code-types)
            (mkAssoc folder-app folder-types)
            (mkAssoc image-app image-types)
            (mkAssoc terminal-app terminal-types)
            (mkAssoc text-app text-types)
            (mkAssoc video-app video-types)
            (mkAssoc web-app web-types)
        ];
    };
}