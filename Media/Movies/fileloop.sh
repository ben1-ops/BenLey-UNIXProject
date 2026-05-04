#!/bin/bash
rm PastetoIndex.txt
count=o
for file in */ ; do
        ((count=count+1))
        if [[ "$count" -eq 1 ]]; then
                echo "<tr>" >> PastetoIndex.txt
        fi;
	if [[ -d "$file" && ! -L "$file" ]]; then
                file=${file%*/}
		link="${file//_/": "}"
		echo "<!DOCTYPE html><html><head><title>$link</title><link rel=\"stylesheet\" href=\"style.css\"></head><body><h1>$link</h1><video width=\"640\" height=\"360\" controls><source src=\"Media/Movies/$file/$file.mp4\">Your browser does not support the video tag.</video></body></html>" > "$file.html"
                echo "<td><a href=\"$file.html\" target=\"_blank\" rel=\"noopener noreferrer\"><img src=\"Media/Movies/$file/$file Poster.avif\" alt=\"$link Poster\" width=\"240\" height=\"360\"><br>$link</a><br></td>" >> PastetoIndex.txt
		mv "$file.html" "/var/www/html"
        fi;
	if [[ "$count" -eq 5 ]]; then
                echo "</tr>" >> PastetoIndex.txt
                count=0;
        fi;
done
if [[ "$count" -ne 0 ]]; then
        echo "</tr>" >> PastetoIndex.txt
fi;
echo "<!DOCTYPE html><html><head><title>Ben Ley Media Server</title><link rel=\"stylesheet\" href=\"style.css\"><style>#protectedContent {display: none;}</style><script> const correctPassword = \"ilovemovies\"; function checkPassword() {const enteredPassword = document.getElementById(\"passwordInput\").value; if (enteredPassword === correctPassword) {document.getElementById(\"protectedContent\").style.display = \"block\";} else if (enteredPassword === '') { alert(\"Please Enter a Password\");} else { alert(\"Incorrect password!\"); }}</script></head><body><h1>Media Server</h1><h2>Enter Password to View Content</h2><input type=\"password\" id=\"passwordInput\" placeholder=\"Enter password\"> <button onclick=\"checkPassword()\">Submit</button><script>document.addEventListener(\"keydown\", function(event) {if (event.key === \"Enter\") {checkPassword();}});</script><div id=\"protectedContent\"><table><tbody>" > index.html
cat PastetoIndex.txt >> index.html
echo "</tbody></table></div></body></html>" >> index.html
mv index.html "/var/www/html"
