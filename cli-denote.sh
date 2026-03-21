#!/bin/sh

# Denote-style creation of notes on the CLI.  This is based on the
# file-naming scheme used by the Emacs Denote package.  See
# https://protesilaos.com/emacs/denote#h:4e9c7512-84dc-4dfb-9fa9-e15d51178e5d
# for more information.

# You will probably want to copy this file to "~/.local/bin/clid"
# (assuming that the "~/.local/bin" directory is in your $PATH), and
# then you will want to run "chmod +x ~/.local/bin/clid".

# Get a unique identifier based on the current time.
dndate () {
    date +"%Y%m%dT%H%M%S"
}

# Get a note title based on user input.
dntitle () {
    local title
    read -p 'Note title: ' title
    echo $title
}

# Get a list of tags.
dntags () {
    local tags
    local input
    local i=1
    while test "$i" = 1 || [ -n "$input" ]
    do
        read -p "Note tag #$i: " input
        if [ -n "$input" ]; then
            if [ "$i" = 1 ]; then
                tags=__"$input"
            else
                tags="$tags"_"$input"
            fi
        fi
        i=$((i+1))
    done
    echo $tags
}

# Get filename for a new note.
dnfilename () {
    local ndate=$(dndate)
    local ntitle=$(dntitle | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g')
    local ntags=$(dntags)
    echo "$ndate"--"$ntitle$ntags.txt"
}

$EDITOR $(dnfilename)
