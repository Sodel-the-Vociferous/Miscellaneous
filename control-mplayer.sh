#!/bin/sh

# I discovered this while fiddling around with the terminal today! Of
# course, in retrospect, it's obvious. This, of course, is just a
# proof of concept, to show you the sort of thing you can do with
# unix pipes.

# Using this same principle, you could very easily write a simple
# graphical front-end for mplayer, or just about any application that
# reads from standard input.

# I wondered what the simplest way to write a mplayer wrapper would
# be, and this is what I came up with. Mplayer is controlled by simple
# key-presses, so just echo the appropriate keypresses over a Unix
# pipe. The following blog post inspired this little experiment:
# http://appliedcoffeetechnology.tumblr.com/post/14073355013

# Do NOT echo a newline after each command.
alias echo="echo -n"

main () {
# Read commands from the user, and echo the appropriate keypresses.
        while true
        do
            read COMMAND
            
            case $COMMAND in
                pause|play)
                    # Yeah, yeah; but, mplayer uses the same
                    # key. Anyways, this is just an example. Don't be
                    # so picky!
                    echo "p"
                    ;;
                louder)
                    echo "*"
                    ;;
                quieter)
                    echo "/"
                    ;;
                quit)
                    echo "q"
                    return 0
                    ;;
            esac
        done
}

# Pipe main()'s output to mplayer; discard mplayer's standard and
# error output.
main | mplayer "$@" > /dev/null 2>&1
