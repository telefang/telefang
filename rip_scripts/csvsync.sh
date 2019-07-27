#!/bin/bash

SPREADSHEET_KEY=1itnJa1EbKQhl5-u5FNS7Ho9F6eOIX32Bwf0XIbCZbhY
SHEETS=(
    # CSV path, GID
    script/story/all.messages.csv           1935066788
    script/npc/all.messages.csv             1435413006
    script/npc/postgame.messages.csv        1999641522
    script/npc/unused.messages.csv          1634712150
    script/calls/denjuu/all.messages.csv    317080452
    script/calls/story.messages.csv         2033175693
    script/calls/exp_item.messages.csv      1056966167
    script/battle/messages.messages.csv     1751024229
    script/battle/arrive_phrases.csv        1010284920
    script/battle/attack_phrases.csv        1274128822
    script/battle/message_unk.csv           1440252416
    script/battle/attacks.csv               632809498
    script/battle/items.csv                 1823319603
    script/battle/tfangers.csv              1306424810
    script/battle/ui_strings.csv            1538855119
    script/battle/nicknames.csv             1784731430
    script/battle/singular.csv              988937655
    script/battle/plural.csv                863997244
    script/denjuu/descriptions.messages.csv 798105385
    script/denjuu/sms.messages.csv          256023144
    script/denjuu/species.csv               17514423
    script/denjuu/statuses.csv              1545746160
    script/denjuu/personalities.csv         1604251478
    script/denjuu/habitats.csv              1012117155
    script/denjuu/nicknames.csv             1018901251
    script/denjuu/article_strings.csv       642445015
    script/map/location_strings.csv         456069826
    script/map/dungeon_strings.csv          63277743
    script/map/dungeon_strings.csv          63277743
    components/credit/credit.messages.csv   71236479
)

for (( i = 0; i < ${#SHEETS[@]}; i += 2 ))
do
    echo "Fetching ${SHEETS[i]}..."
    wget -q --no-check-certificate -O ${SHEETS[i]} "https://docs.google.com/spreadsheets/d/${SPREADSHEET_KEY}/export?format=csv&gid=${SHEETS[i + 1]}"
    EXIT_CODE=$?
    if [ $EXIT_CODE != 0 ] ; then
        echo "Failed to fetch ${SHEETS[i]} (https://docs.google.com/spreadsheets/d/${SPREADSHEET_KEY}/export?format=csv&gid=${SHEETS[i + 1]})." >&2
        exit ${EXIT_CODE}
    fi
done

echo "All done!"
