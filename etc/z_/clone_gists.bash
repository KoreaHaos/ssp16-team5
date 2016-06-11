:<<EOF
EOF
# ToDo: Make it name the folders with the gists name rather then its ID.
# This clones each gist into a folder using the gists ID to name the folder.
gist -l | grep -Eo '(http|https)://[^ ]+' | awk '{print $1".git"}' | while read -r line; do git clone "$line"; done

# This list the URLs for cloning an authenticated users' gists.
#gist -l | grep -Eo '(http|https)://[^ ]+' | awk '{print $1".git"}'

# This lists an authenticated users' gist URLs.
# gist -l | grep -Eo '(http|https)://[^ ]+'

# This lists an authenticated users' gist URLs and the gist's description.
# gist -l
