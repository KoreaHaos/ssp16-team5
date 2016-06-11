:<<EOF
EOF

# This script performs some routine repository management tasks.

# Status : Being developed! (clearly! %)

# ToDo : Figure out if it is tracking and pushing all branches. (Pretty sure it is (5/2/16))

# ToDo : Add viewing of remotes to options. 

# ToDo : Offer to pull if push fails.

# ToDo : Signal remote when script queries for username!

# DO NOT USE UNLESS YOU UNDERSTAND WHAT IT DOES!! READ THE CODE!! IT WILL MOST LIKELY CAUSE PROBLEMS!!

# ToDo : figure out some way to only work on the user's repositories and ignore any repos that were clone from sources without push rights.

# ToDo : Setup machine generate commit message to use Cloud9 enviornmental variables or some other value relavent to the machine generating and/or the repository itself.
# ToDo : Clean up the output!

# ToDo : Have UI display menu options. (see show_options function.)

# ToDo : Have UI display commit message.

# ToDo : Designate and set up an arguement so the UI can be bypassed.

# ToDo : Make output more readable.
#           - Create white spacing.
#           - Handle errors!
#           -

# ToDo : Have it create logs of what its done in each repo it's worked on.

# ToDo : Offer menu chose to show repos' remote URLs.

# ToDo : Automate production and management of gh-pages branches.
# ToDo : Offer an option to switch all the repos that have gh-pages to that branch.
# ToDo : Add auto quit after input.
# ToDo : 
# ToDo : 

# ToDo : Abstract (is that the right word?) out the switch statement into a menu system.

function run_program_loop() {
    local users_choice
    user_wants_to_quit="false"
    local run_it_quick="false"
    
    if [ ! -z "$1" ]
    then
        run_it_quick="true"
    fi
        
    while [ "$user_wants_to_quit" != "true" ]
    do
        if [ "$run_it_quick" != "true" ]
        then
            offer_and_execute_options_available
        else
            offer_and_execute_options_available "$1"
        fi
    done
    
}

# This functions is used for script testing during debug, update, da-de-da, deet-da-dee. (NEEDS TO BE FINISHED!)
function run_latest_testing() {

    echo
    #offer_and_execute_options_available
    
}

# Shows a list of functions available to call in a menu system.

function offer_and_execute_options_available() {

    populate_array
    
    # Get temp list if runable function in script.
    local temp=$(grep "^function" $0 | tr -d '(){'  |  cut -f2- -d ' ')

    # Create seperate key and function lists.
    local key_for_call=$(echo "$temp" | grep -io "^[a-z]_"  |  tr -d '_')
    local function_to_call=$(echo "$temp" | grep -i "^[a-z]_" | cut -f2- -d '_') 
    
    # Create a key/value associative array of the runnable functions.
    declare -A key_letter_and_function_call_map
    
    # Put the keys into the array.
    for line in $key_for_call
    do
        key_letter_and_function_call_map[$line]="tmp"
    done

    # Make a key ring!
    KEYS=(${!key_letter_and_function_call_map[@]}) 
    
    # Attach the callable functions to the keys.
    local index=0
    for line in $function_to_call
    do
        KEY=${KEYS[$index]}
        key_letter_and_function_call_map[$KEY]="$line"
        ((index++))
    done

    if [ -z "$1" ]
    then
        
        echo ""
        # Display the menu of callable functions
        for (( i = 0; $i < ${#key_letter_and_function_call_map[@]}; i+=1 ))
        do
            KEY=${KEYS[$i]}
            echo $KEY : ${key_letter_and_function_call_map[$KEY]}
        done
        echo""
        
        # Query for choice frm user.
        read -p "Your choice? : " -n 1 -r
        echo
        echo
    
    else
        REPLY="$1"
        user_wants_to_quit="true"
    fi
    
    if [ ! -z "${key_letter_and_function_call_map[$REPLY]}" ]
    then
        echo "Your choice : $REPLY"
        function_to_run=$REPLY"_"${key_letter_and_function_call_map["$REPLY"]}
        
        read -p "Run function $REPLY_${key_letter_and_function_call_map["$REPLY"]}? (y/n) : " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]
        then
            eval "$function_to_run"
        fi

    else
        echo "Huh? You entered $REPLY, that does not seem to be a valid choice!"
    fi
    
    read -p "return to cont : " varnotuse
}

# ToDo : Fix this so the commit message has new lines.
# Writing a temp file for the commit message seems like the best method.
function create_cloud9_manage_git_directories_script_commit() {
    # Create a local return variable and assign it to param one.
    # FYI, it's best to just ignore this var until your ready to return something...
    local  return_commit=$1
    
    # A commit msg is generally a line of text and most likely has some requirements, so
    # ToDo : figure out git commit message limitations.
    
    local init_commit=""
    
    init_commit="${init_commit}Script commit from Cloud9 VM(C9)."
    
    init_commit="${init_commit}C9 user : "
    local cloudusers_name_full=$C9_FULLNAME
    init_commit="$init_commit$cloudusers_name_full."
    
    init_commit="${init_commit} Committing script name : "
    local this_scripts_name=$0
    init="$init_commit$this_scripts_name."
    
    init_commit="${init_commit} Script committing function name : "
    local this_funs_name=$FUNCNAME
    init_commit="${init_commit}$FUNCNAME."
 
    # this line essentially, passes back our return variable.
    # FYI, best kept at the end of the function...
    eval $return_commit="'$init_commit'"
}

# source_a : http://www.linuxjournal.com/content/return-values-bash-functions
function create_commit_message_finished_test() {
    local commit_to_return="function create_commit_message_finished_test inital commit message"
    local  return_var=$1
    eval $return_var="'$commit_to_return'"
}

function ask_for_key_press() {
    local user_input
    read -n1 -r -p "Any key to continue : " user_input
    echo ""
}

function ask_for_key_press_allow_quit() {
    local user_input
    read -n1 -r -p "Any key to continue (q to quit) : " user_input
    echo ""
    if [ "$user_input" = 'q' ]; then
        exit;
    fi
}

function populate_array() {
    count=0;
    GIT_DIRS=()
    
    while IFS= read -r -d $'\0' file; do
      let "count++"
      GIT_DIRS[$count]="$file"
    done < <(find . -name .git -type d -prune -print0)
    
    if [ -z "$1" ]
    then
        echo "Found $count git directories!"
        d_display_git_directories
    else
        case "$1" in
            "-q")
                ;;
            "-v")
                D_display_git_directories_their_branches_and_their_status
                ;;
            *)
                echo "PROBLEM!!"
        esac
    fi
}

function A_add_all_commit_all_push_all() {
    add_all_commit_all_and_push_all_is "true" 
}

function D_display_git_directories_their_branches_and_their_status() {
    for git_directory in "${GIT_DIRS[@]}"
    do
        #printf "\n\n";
        cd $git_directory;
        cd ..
        printf "\nIn : %s \n" $PWD;
        printf "\nGIT STATUS\n";
        git status
        printf "\nREPOSITORY BRANCHES\n\n";
        git branch -v
        cd $CALLED_FROM_DIR;
    done
}

function a_add_all_commit_all() {
    add_all_commit_all_and_push_all_is "false" 
}

function c_cache_git_creds_for_x_minutes() {
    local num_minutes
    read -p "Time in minutes to cashe the dits? : " num_minutes;
    
    # ToDo : Figure out how to display the timeout value and echo it back!
    let "num_minutes = $num_minutes * 60"
    git config --global credential.helper "cache --timeout=$num_minutes"
}

function d_display_git_directories() {
    for git_directory in "${GIT_DIRS[@]}"
    do

      local string_cut_front="${git_directory#./}"
      echo ${string_cut_front%/.*}
      
    done
}

function p_pull_all_repos() {
    for git_directory in "${GIT_DIRS[@]}"
    do
      cd $git_directory;
      cd ..

      git pull
      
      cd $CALLED_FROM_DIR;
    done
}

function s_show_status_of_all_repos() {
    for git_directory in "${GIT_DIRS[@]}"
    do
      cd $git_directory;
      cd ..

      git status
      
      cd $CALLED_FROM_DIR;
    done
}

function x_exit_program() {
    user_wants_to_quit="true"
}

function say_hello() {
    echo "Work with git directories!"
    printf "Working directory is : %s\n" $PWD
}

function init_program() {
    clear
    print_a_bunch_of_blank_lines 10
    count=0;
    GIT_DIRS=();
    CALLED_FROM_DIR="$PWD";
}

function print_a_bunch_of_blank_lines() {
    
    local num_lines_to_print=15;
    
    if [ ! -z "$1" ]
    then
        num_lines_to_print="$1"
    fi
    
    for i in `seq 1 $num_lines_to_print`;
        do
                #printf "%s\n" "$1";    # <--- Usefull for experiments,
                printf "\n";            # <--- comment this out to use.
        done
}

function add_all_commit_all_and_push_all_is() {
    
    if [ ! -z "$1" ]
    then
        local commit_message=""
        create_cloud9_manage_git_directories_script_commit commit_message
        
        for git_directory in "${GIT_DIRS[@]}"
        do
            
            echo ""
            echo "* * * * * * * ** * * * * * * ** * * * * * * ** * * * * * * *"
            echo ""
            
            
            cd $git_directory;
            cd ..
            
            git add .
            git commit -m "$commit_message"
            
            if [ "$1" == "true" ]
            then
                git push --all
            fi
            
            cd $CALLED_FROM_DIR;
        done
    else
        echo "PROBLEM CALLING GIT $FUNCNAME"
    fi
}


cd $GOPATH

say_hello
init_program

if [ -z "$1" ]
then
    run_program_loop
else
    run_program_loop "$1"
fi

:<<EOF
EOF

