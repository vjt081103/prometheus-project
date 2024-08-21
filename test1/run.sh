#!/bin/bash

targets="/app/iventory.yml"
config="/app/prometheus.yml"
output="/app/hello.yml"
insertlines=7

> "$output"

head -n "$insertlines" "$config" >> "$output"

while read -r line; do
  clean_line=$(echo "$line" | tr -d '\r' | tr -d '\020')
  if [[ $clean_line =~ ^\[(.*)\]$ ]]; then
    echo "hello"
  elif [[ -n $clean_line ]]; then
    echo "          - '$clean_line:9100'" >> "$output"
  fi
done < "$targets"


sed -n "$((insertlines + 1)),$ p" "$config" >> "$output"


echo "" >> "$output"