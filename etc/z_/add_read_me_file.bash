:<<EOF
This is a script for creating basic readme files.


There are only six questions that can ever be asked.
... let's automate that!

STATUS : Finished for turn-in!

ToDo : Set this up so it can be applied to ALL THE FILES!!!
ToDo : Stop being so ambitious?
ToDo : Have it output the readme file so user knows what they did.
ToDo : 
EOF

function make_readme() {

    local text_for_file=$'';
    
    text_for_file+=$'\n\n**SCRIPTED READ ME APPEND!!**\n\n';
    text_for_file+=$'#### **WHO!**\n';
    text_for_file+=$'* *put text here!*\n';
    text_for_file+=$'#### **WHAT!**\n';
    text_for_file+=$'* *put text here!*\n';
    text_for_file+=$'#### **WHERE!**\n';
    text_for_file+=$'* *put text here!*\n';
    text_for_file+=$'#### **WHEN!**\n';
    text_for_file+=$'* *put text here!*\n';
    text_for_file+=$'#### **WHY!**\n';
    text_for_file+=$'* *put text here!*\n';
    text_for_file+=$'#### **HOW!**\n';
    text_for_file+=$'* *put text here!*\n';

    
    printf "%s" "$text_for_file" >> "$1"/README.md
    #echo "$1"README.md
}

if [ -e ""$1"/README.md" ]
then
    echo "File $1/README.md exists."
else
    make_readme "$1"
fi