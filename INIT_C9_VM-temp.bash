# A fresh VM always needs a little setup

# ToDo : Figure out how to setup the gitnor to not track the removal of files.
# ToDo : Have it delete itself.

# Make VM cacke git creds
time_to_cache_dits_for="86400"
git config --global credential.helper "cache --timeout=$time_to_cache_dits_for"

# This line changes the bash history.
bash etc/z_/hack_the_bash_history.bash

