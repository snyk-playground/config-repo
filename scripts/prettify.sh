#!/bin/bash

prettify(){
  input_file="$1"
  temp_json_file=$(mktemp)

  jq . "$input_file" > "$temp_json_file"

  mv "$temp_json_file" "$input_file"
}


TARGET="$SNYK_LOG_PATH"

readarray -t import_log_files < <(find "${TARGET}" -type f -name "*.log" )

for log_file in "${import_log_files[@]}"; do
  prettify "${log_file}"
done