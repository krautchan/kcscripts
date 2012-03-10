#!/bin/bash
# Fadenarchivierer.
# Nutzung: ./krautdump.sh DLDIR THREAD
downloaddir="$1"
# lolantipattern
host=$(echo "$2" | awk -F "/" '{print $3}')
if echo $2 | grep -q /board/; then
        board=$(echo "$2" | awk -F "/" '{print $5}')
        thread=$(echo "$2" | awk -F "/" '{print $7}')
else
        board=$(echo "$2" | awk -F "/" '{print $4}')
        thread=$(echo "$2" | awk -F "/" '{print gensub("[^0-9]","","g",$5)}')
fi
url="http://$host/$board/thread-$thread.html"
echo $url;

if [ ! "$2" ]; then echo "Ja, und weiter?"; exit 1; fi
if [ -z "$board" -o -z "$thread" ]; then echo "Kann ich nix mit anfangen."; exit 1; fi
if wget --spider -q "$url"; then :; else echo "404 ;_;"; exit 1; fi

wget -P "$downloaddir/kc-$board-$thread" -nv -rpkKENH -l 1 -e robots=off --header='Cache-Control: no-cache' -I js,css,images,thumbnails,download,banner,uds "$url"
#TODO tarballoption
# --exclude-directories=js/scriptaculous
