#!/bin/sh

SQLITE_INPUT_FILE=$1
MD_OUTPUT_FILE=$2



echo '' > "$MD_OUTPUT_FILE"
{
echo '---'
echo 'title: Kobo highlights & notes' >> "$MD_OUTPUT_FILE"
echo '...'
echo ''
echo '\tableofcontents'
echo ''
} >> "$MD_OUTPUT_FILE"



current_book=""
offset=0

while : ; do
    fullfilename=$(sqlite3 KoboReader.sqlite "select VolumeId from Bookmark limit 1 offset $offset")
    date=$(sqlite3 KoboReader.sqlite "select DateModified from Bookmark limit 1 offset $offset")
    highlight=$(sqlite3 KoboReader.sqlite "select Text from Bookmark limit 1 offset $offset")

    if [ "$fullfilename" = "" ]; then
        break
    fi

    # fullfilename=$(echo "$raw_entry" | cut -f1 -d"|")
    filepath="${fullfilename%.*}"
    filename=$(basename "$filepath")
    echo "$filename"

    if [ "$filename" != "$current_book" ]; then
        current_book="$filename"
        {
        echo ""
        echo "# $filename"
        echo ""
        } >> "$MD_OUTPUT_FILE"
    fi

    # highlight=$(cut -f2 -d"|" "$raw_entry")
    # date=$(cut -f3 -d"|" "$raw_entry")

    # echo "$raw_entry" >> "$MD_OUTPUT_FILE"

    offset=$((offset+1))
done

# file:///mnt/onboard/Parker, Matt/Humble Pi_ A Comedy of Maths Errors - Matt Parker.epub|Programming is just formalized mathematical thought and processes.|2020-10-08T18:29:46Z
