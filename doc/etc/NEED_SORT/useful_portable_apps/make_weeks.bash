#!/bin/bash

# Need to put a file in each folder so the folder structure gets tracked with git.
function make_readme {
cat >README.md<<EOL
# $1
EOL
}


mkdir weeks
cd weeks

for i in `seq 1 16`;
do
       mkdir week$i
       cd week$i
       make_readme "week $i"
       cd ..
done
    