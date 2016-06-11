# This scripts creates a reveal.js boilerplate.

# Use at your own risk!

# ToDo : Create various boilerplate templets.

function remove_unused_bits() {
    rm -rf .git
    rm -rf test
    rm .gitignore
    rm .travis.yml
    rm bower.json
    rm CONTRIBUTING.md 
    rm Gruntfile.js 
    rm package.json 
    rm README.md 
}

function clone_reveal_js_into_boilerplate_directory() {
    local directory_to_put_boilerplate_in="b_reveal_js_directory"
    git clone https://github.com/hakimel/reveal.js.git $directory_to_put_boilerplate_in
    cd $directory_to_put_boilerplate_in
    remove_unused_bits $directory_to_put_boilerplate_in
}

function say_hello() {
    echo ""
    echo "Hello and Welcome to a Scripted Haos Bash Production!"
    echo ""
    echo "This script creates a folder containing a boilerplate of reveal.js."
    echo ""
    echo "NOTE : "
    echo ""
    echo "It is designed for a Cloud9 Virtual-Machine(VM) and creates the"
    echo "folder in the VM's project directory."
    echo ""
}

function ask_to_continue_break_if_not_approved() {
    # The logic of this function was cribbed from :
    # http://stackoverflow.com/questions/1885525/how-do-i-prompt-a-user-for-confirmation-in-bash-script
    
    local users_choice
    read -p "Would you like to continue? (y/n) : " -n 1 -r
    echo    # Move to a new line
    if [[ ! $REPLY =~ ^[Yy]$ ]]
    then
        #Non-Yes response found.
        echo "Thanks for stopping by!"
        exit 1
    else
        # Yes response found.
        echo "Then let's do it!"
    fi
}

function run_the_script() {
    clear
    say_hello
    ask_to_continue_break_if_not_approved
    cd $GOPATH
    clone_reveal_js_into_boilerplate_directory
    echo ""
    echo "The script finished and created the boiler plate of reveal.js."
    echo ""
    
}

run_the_script
# WISHLIST : Have it create a html file linking to all the decks.