
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
    echo 123
}

main() {
    while true; do
        # Read headers
        content_length=0
        while IFS= read -r line; do
            [[ "$line" == $'\r' || -z "$line" ]] && break
            if [[ "$line" =~ Content-Length:\ ([0-9]+) ]]; then
                content_length=${BASH_REMATCH[1]}
            fi
        done

        # Read body
        if (( content_length > 0 )); then
            read -r -n "$content_length" body
            id=$(echo "$body" | grep -o '"id":[^,}]*' | head -1 | cut -d: -f2 | tr -d ' ')
            method=$(echo "$body" | grep -o '"method":"[^"]*"' | cut -d: -f2 | tr -d '"')

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
        fi
    done
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi
