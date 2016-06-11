user_to_scrape="$1"
url_to_scrape="https://codebender.cc/user/$user_to_scrape"

mkdir codebender_files
cd codebender_files

wget  $url_to_scrape -q -O - |grep -Po '(?<=href="/sketch:)[^"]*' | awk -v var="$user_to_scrape" '{print "https://codebender.cc/utilities/download/"$1"?referrer="var""}' |xargs wget

for file_got in *
do
    unzip $file_got
    rm $file_got
done

cd ..

mkdir ./smart_software_project_codebender_files
find ./codebender_files -maxdepth 1 -type d -name 'smart_software_project*' -exec cp -rf {} ./smart_software_project_codebender_files \;

mkdir ./basic_engineering_design_codebender_files
find ./codebender_files -maxdepth 1 -type d -name '36564_1_basic _engineering*' -exec cp -rf {} ./basic_engineering_design_codebender_files \;

mkdir ./other_misc_codebender_files
find ./codebender_files -maxdepth 1 -type d ! -name '36564_1_basic _engineering*' ! -name 'smart_software_project**' -exec cp -rf {} ./other_misc_codebender_files \;

rm -rf codebender_files