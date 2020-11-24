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
    date_raw=$(sqlite3 KoboReader.sqlite "select DateCreated from Bookmark limit 1 offset $offset")
    highlight=$(sqlite3 KoboReader.sqlite "select Text from Bookmark limit 1 offset $offset")
    annotation=$(sqlite3 KoboReader.sqlite "select Annotation from Bookmark limit 1 offset $offset")

    if [ "$fullfilename" = "" ]; then
        break
    fi

    # fullfilename=$(echo "$raw_entry" | cut -f1 -d"|")
    filepath="${fullfilename%.*}"
    filename=$(basename "$filepath")
    bookname=$(echo "$filename" | cut -f1 -d"_" | cut -f1 -d"-")
    echo "$bookname"

    if [ "$bookname" != "$current_book" ]; then
        current_book="$bookname"
        {
        echo ""
        echo "# $bookname"
        echo ""
        } >> "$MD_OUTPUT_FILE"
    fi

    date=$(echo "$date_raw" | cut -f1 -d"T")

    echo "$highlight" | while read -r line
    do
        if [ "$line" != "" ]; then
            echo "> $line" >> "$MD_OUTPUT_FILE"
        fi
    done

    {
    echo "*$date*"
    echo ""
    echo ""
    } >> "$MD_OUTPUT_FILE"

    echo "$annotation" | while read -r line
    do
        if [ "$line" != "" ]; then
            echo "| $line" >> "$MD_OUTPUT_FILE"
        fi
    done

    {
    echo ""
    echo ""
    } >> "$MD_OUTPUT_FILE"


    offset=$((offset+1))
done
