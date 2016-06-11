function modify_history() {
    cd $GOPATH
    cd ..
    
    echo "$most_imporant_history_item" > $GOPATH/tempfile
    #echo 'line 2' >> $GOPATH/tempfile
    
    cat .bash_history >> $GOPATH/tempfile
    
    cp $GOPATH/tempfile .bash_history
}

function set_scripts_path() {
    SCRIPTS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" 
}

function set_scripts_path_and_name() {
    SCRIPTS_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"    
}

set_scripts_path
set_scripts_path_and_name

most_imporant_history_item="bash $SCRIPTS_DIR/manage_git_directories.bash"

modify_history

echo "You need to close your terminal and reopen before history mods will occure."