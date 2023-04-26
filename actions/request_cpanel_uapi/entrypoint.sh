#!/bin/sh -l

set -eu

usage() {
  echo "\nUsage: $0 [base_url] [user] [token] [method] [resource_path] [fields]"
  echo ""
  echo "Required arguments:"
  echo "  base_url:        The base URL of the API."
  echo "  user:            The username to authenticate with."
  echo "  token:           The authentication token."
  echo "  resource_path:   The resource path for the API endpoint."
  echo ""
  echo "Optional arguments:"
  echo "  method:          The HTTP method to use (e.g. GET, POST). Default 'GET'"
  echo "  fields:          Comma-separated list of key-value pairs to include as form data."
  echo ""
}

main() {
  base_url="${1:-}"
  user="${2:-}"
  token="${3:-}"
  resource_path="${4:-}"
  method="${5:-GET}"
  fields="${6:-}"

  local exit_code=0

  if [ -z "$base_url" ] || [ -z "$user" ] || [ -z "$token" ] || [ -z "$resource_path" ]; then
    echo "Error: Missing required arguments."
    usage
    exit 1
  fi

  curl_command=$(build_curl_command "$base_url" "$user" "$token" "$method" "$resource_path" "$fields")
  printf "curl command: %s\n" "$curl_command"

  printf "executing...\n"
  result=$(eval "$curl_command")
  printf "result log: %s\n" "$result"

  status_code=$(echo "$result" | jq '.status')
  errors=$(echo "$result" | jq '.errors')

  if [ "$status_code" -eq 0 ]
  then
    printf "ERROR: files could not be uploaded\n"
    exit_code=1;
  fi

  printf "status_code=%s\n" "$status_code" >> "$GITHUB_OUTPUT"
  printf "errors=%s\n" "$errors" >> "$GITHUB_OUTPUT"
  printf "Successful upload files\n"
  exit $exit_code
}

build_curl_command() {
  local base_url="$1"
  local user="$2"
  local token="$3"
  local method="$4"
  local resource_path="$5"
  local fields="$6"

  local curl_command="curl -X $method \
    -H'Authorization: cpanel $user:$token'"

  # Add additional fields
  if [ -n "$fields" ]; then
    IFS=","
    fields_array=""
    set -- $fields
    for field do
      fields_array="$fields_array -F '${field}'"
    done
    curl_command="$curl_command $fields_array"
  fi

  curl_command="$curl_command '${base_url}/${resource_path}'"
  
  echo "$curl_command"
}

main "$@"