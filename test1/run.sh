#!/bin/bash

targets="/app/iventory.yml"
config="/app/config.yml"
output="/app/prometheus.yml"
insertlines=11

> "$output"

head -n "$insertlines" "$config" >> "$output"

while IFS= read -r line || [ -n "$line" ]; do
  clean_line=$(echo "$line" | tr -d '\r' | tr -d '\020')
  if [[ $clean_line =~ ^\[(.*)\]$ ]]; then
    echo "hello"
  elif [[ -n $clean_line ]]; then
    echo "          - '$clean_line:9100'" >> "$output"
  fi
done < "$targets"


sed -n "$((insertlines + 1)),$ p" "$config" >> "$output"


echo "" >> "$output"