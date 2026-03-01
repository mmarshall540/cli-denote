# Denote-style creation of notes on the CLI.

# Either source this file in your ~/.bashrc, or just copy the function
# definitions directly into that file.

# Use `dnnote` to create a new note using the `nano` text editor.

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
    while test "$i" == 1 || [ -n "$input" ]
    do
        read -p "Note tag #$i: " input
        if [ -n "$input" ]; then
            if [ $i == 1 ]; then
                tags=__"$input"
            else
                tags="$tags"_"$input"
            fi
        fi
        ((i++))
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

dnnote () {
    nano $(dnfilename)
}
