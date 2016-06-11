# A fresh VM always needs a little setup

# ToDo : Figure out how to setup the gitnor to not track the removal of files.
# ToDo : Have it delete itself.

# This line changes the bash history.



function make_history_change() {
    bash "$HISTORY_CHANGING__PATH_AND_FILENAME"
}

function setup_changes_in_history() {
    THIS_SCRIPTS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    HISTORY_CHANGING__PATH_AND_FILENAME="$THIS_SCRIPTS_DIR/etc/z_/hack_the_bash_history.bash"
}

setup_changes_in_history
make_history_change

