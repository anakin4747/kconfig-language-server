
#!/usr/bin/env bash

send_response() {
    local response="$1"
    local length=${#response}
    printf "Content-Length: %d\r\n\r\n%s" "$length" "$response"
}

handle_initialize() {
    local id="$1"
    send_response "$(cat <<EOF
{
  "jsonrpc": "2.0",
  "id": $id,
  "result": {
    "capabilities": {
      "hoverProvider": true
    }
  }
}
EOF
)"
}

handle_hover() {
    local id="$1"
    send_response "$(cat <<EOF
{
  "jsonrpc": "2.0",
  "id": $id,
  "result": {
    "contents": {
      "kind": "markdown",
      "value": "**Hello from Bash LSP!**"
    }
  }
}
EOF
)"
}

parse_headers() {
    local content_length=0
    while IFS= read -r line; do
        [[ "$line" == $'\r' || -z "$line" ]] && break
        if [[ "$line" =~ Content-Length:\ ([0-9]+) ]]; then
            content_length=${BASH_REMATCH[1]}
        fi
    done
    echo "$content_length"
}

log() {
    echo "$*" >> /home/kin/src/kconfig-lsp/log
}

get_id() {
    local id="$(echo "$1" | jq -r .id)"
    if [[ "$id" == "null" ]]; then
        id=""
    fi
    echo "$id"
}

main() {
    while true; do
        local content_length="$(parse_headers)"

        if (( content_length < 0 )); then
            continue
        fi

        read -r -n "$content_length" body
        echo "$body" >> /home/kin/src/kconfig-lsp/test/bodies

        local id="$(get_id "$body")"
        local method="$(echo "$body" | jq -r .method)"

        case "$method" in
          "initialize")
              handle_initialize "$id"
              ;;
          "textDocument/hover")
              handle_hover "$id"
              ;;
          "shutdown")
              send_response "{\"jsonrpc\":\"2.0\",\"id\":$id,\"result\":null}"
              ;;
          "exit")
              exit 0
              ;;
        esac
    done
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi
