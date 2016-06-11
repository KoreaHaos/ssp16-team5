# ToDo : Have it ask for user input and/or except arguements.

page_title="script_created_index"
output_file="index_boiler.html"

cat >"$output_file"<<EOF
<!DOCTYPE html>
<html>
    <head>
        <title>$page_title</title>
    </head>
    <body>
    <ul>
EOF

ls *.html | cut -f 1 -d '.' | awk '{print "      <li><a href=\""$1".html\">"$1"</a></li>"}' >> $output_file

cat >>"$output_file"<<EOF
    </ul>
    </body>
</html>
EOF
