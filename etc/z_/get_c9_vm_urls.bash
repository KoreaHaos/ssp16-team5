# Theses lines will create a simple HTML file with a links to all the C9 virtual machines.

# The input file needs to be manually produced...
# log into Cloud9 at : https://c9.io/login
# copy/paste the view source into a file input.html
# Change <user_name> to whatever your user id is.

input_file='input.html'
output_file='virtual_machine_list.html'
user_name='koreahaos'


cat >"$output_file"<<EOF
<!DOCTYPE html>
<html>
    <head>
        <title>$page_title</title>
    </head>
    <body>
    <ul>
EOF

cat $input_file | grep -Eo "https://ide.c9.io/$user_name/[a-zA-Z0-9./?=_-]*" | sort | uniq | awk '{print "      <li><a href=\""$1"\" target=\"blank\">"$1"</a></li>"}'  >> $output_file

cat >>"$output_file"<<EOF
    </ul>
    </body>
</html>
EOF

