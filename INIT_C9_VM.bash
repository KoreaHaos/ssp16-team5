# A fresh VM always needs a little setup

# ToDo : Figure out how to setup the gitnor to not track the removal of files.
# ToDo : Have it delete itself.

# This line changes the bash history.

function c_cache_git_creds_for_x_minutes() {
    local num_minutes
    
    if [ -z "$1" ]
    then
        read -p "Time in minutes to cashe the dits? : " num_minutes;
    else
        num_minutes="$1"
    fi
    
    # ToDo : Figure out how to display the timeout value and echo it back!
    let "num_minutes = $num_minutes * 60"
    git config --global credential.helper "cache --timeout=$num_minutes"
}

function make_history_change() {
    bash "$HISTORY_CHANGING__PATH_AND_FILENAME"
}

function setup_changes_in_history() {
    THIS_SCRIPTS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    HISTORY_CHANGING__PATH_AND_FILENAME="$THIS_SCRIPTS_DIR/etc/z_/hack_the_bash_history.bash"
}

c_cache_git_creds_for_x_minutes "1440"
setup_changes_in_history
make_history_change

rm echo "$THIS_SCRIPTS_DIR/$0"
git update-index --assume-unchanged 