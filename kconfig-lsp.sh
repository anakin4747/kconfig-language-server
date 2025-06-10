
#!/usr/bin/env bash

rpc_to_json() {
    sed -E '
        s/([a-zA-Z_][a-zA-Z0-9_]*) *=/\1:/g
        s/: *"([^"]*)"/: "\1"/g
        s/: *([0-9]+)/: \1/g
        s/: *([a-zA-Z_][a-zA-Z0-9_\/\.\-]*)/: "\1"/g
        s/([{\[,]) *([a-zA-Z_][a-zA-Z0-9_]*) *:/\1 "\2":/g
    '
}

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
        method=$(echo "$body" | rpc_to_json | jq .method)
        id=$(echo "$body" | rpc_to_json | jq .id)

        case "$method" in
          "initialize")
              handle_initialize "$id"
              ;;
          "textDocument/hover")
              handle_hover "$body"
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
