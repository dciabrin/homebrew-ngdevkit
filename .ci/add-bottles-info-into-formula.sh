#!/bin/bash
set -ue

# how many lines in the final diff chunk
lines=$(grep -h -e '^+ ' bottle-*.diff | sort -u | wc -l | tr -d ' ')

# construct the new diff with inlined bottle info and updated patch metadata
awk -F'[, +-]' '
/@@/     {print "@@ -"$3","$4" +"$3","($4+'${lines}'+1)" @@"; next}
/\+.*sha256/ { system("grep -h \"+.*sha256\" bottle-*.diff | column -t -s\\\" | sed -e \"s/  \\([^ ]*\\) *$/\\\"\\1\\\"/\""); next}
         {print $0}
' $(ls -1 bottle-*.diff | head -1) > all-bottles.diff

# update the target formula
patch -p1 < all-bottles.diff

echo "bottles data added to formula:"
cat all-bottles.diff
