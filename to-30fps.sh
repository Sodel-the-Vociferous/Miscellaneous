#!/bin/sh
# 2011, Daniel Ralston <Wubbulous@gmail.com>

# My brother and his friends keep making movies on our Sony digital
# camera. I wish we had a real digital video camcorder, but such is
# life. Anyways, whenever he tries to edit them in Windows Movie
# Maker, it starts getting heart palpitations and botches the sound
# synchronization. MEncoder converts the footage into a format that
# WMM understands, for great justice!

for filename in $@
do
    # Hehehe, I'm sure there's a way I'm *supposed* to do this, but I
    # haven't done any obscene sed abuse in far too long... This regex
    # (actually line noise) replaces everything after the final '.' in
    # the old filename with 'avi'.
    new_filename=$(echo $filename | sed -re "s/(.*)\.[^\.]*$/\1\.avi/")

    # If the new filename exists, back it up.
    if [ -e $new_filename ]
    then
        # Yes, I know I should check to see if the .bak file already
        # exists, boo hoo, et cetera... Also, this way of doing string
        # concatenation is dumb.
	bak=".bak"
        mv "$new_filename" "$new_filename$bak"
    fi

    echo "Converting $filename..."
    # That stupid Sony camera. 30 frames per second: sweet sanity.
    mencoder -ofps 30 -oac pcm -ovc lavc -o $new_filename $filename 2>1 > /dev/null
done

echo "Done!"