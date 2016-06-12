# This script will Create a zip file that can be downloaded to your desktop and
# then dropped into a the broswer window for codebender.

# It's not perfect, but what is?

parent_folder_path="$GOPATH"
zip_file_name="haos_smartcar.zip"
folder_to_zip="haos_smartcar_project/"

# Move to directory where sketch is stored.
cd "parent_folder_path"

# Remove any prevoius zip present
if [ -e "$zip_file_name" ]
then
    rm "$zip_file_name"
fi

# Zip all the files useable in the CodeBender IDE
zip -9 -y -r -q -j "$zip_file_name" "$folder_to_zip"/ -i '*.ino' '*.cpp' '*.h'
