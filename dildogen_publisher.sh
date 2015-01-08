#!/bin/bash

piwik_file="Piwik_Code.html.txt"
google_file="Google_Code.html.txt"
paypal_file="PayPal_Spendenbutton.html.txt"

piwik_placeholder="<!-- PIWIK PLACEHOLDER -->"
google_placeholder="<!-- GOOGLE PLACEHOLDER -->"
paypal_placeholder="<!-- PAYPAL PLACEHOLDER -->"


input_files[0]="extrusiongen/main.html"
input_files[1]="extrusiongen/gallery/index.php"

# This is SH syntax
# red='\033[0;31m' # Not in use
#green='\033[0;32m' # It a grocer: It's green
#NC='\033[0m'       # No Color

# This is BASH syntax
green="\e[00;32m"
NC="\e[00;39m"

text_ok="${green}OK${NC}"
#text_ok="\e[00;32mOK"

# 'echo -n' suppresses the newline character at the end of the line
echo -n "Reading Piwik file ... "
piwik_code=$(cat $piwik_file)
# 'echo -e' enables escaped character, such as colors
echo -e $text_ok

echo -n "Reading Google file ... "
google_code=$(cat $google_file)
echo -e $text_ok

echo -n "Reading PayPal file ... "
paypal_code=$(cat $paypal_file)
echo -e $text_ok




# First escape the three special characters: backslash itself, forward slash and end-of-statement
# Then escape double quotes (second SED call)
piwik_code=$(echo $piwik_code | sed -e 's/[\/&]/\\&/g' | sed "s/\"/\\\\\"/g")
google_code=$(echo $google_code | sed -e 's/[\/&]/\\&/g' | sed "s/\"/\\\\\"/g")
paypal_code=$(echo $paypal_code | sed -e 's/[\/&]/\\&/g' | sed "s/\"/\\\\\"/g")


# Replace text in HTML file
#echo $piwik_code
#cat test.html | sed "s/$piwik_placeholder/$piwik_code/g"



new="new"
for file in "${input_files[@]}"
do 
    echo "Processing file $file"
    cat "$file" | sed "s/$piwik_placeholder/$piwik_code/g" > "$file.$new"
done
