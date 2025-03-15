#!/bin/bash

URL="https://www.iana.org/assignments/protocol-numbers/protocol-numbers-1.csv"

mkdir -p fs/etc
curl "$URL" --no-progress-meter | \
  tail -n +2 | head -n -4 | \
  awk -F ',' '{printf(tolower($2) "\t" $1 "\t" $2 "\t# " $3 " " $5 "\n");}' \
  > fs/etc/protocols
