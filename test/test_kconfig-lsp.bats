#!/usr/bin/env bats

setup() {
    source kconfig-lsp.sh
}

@test "parse_headers returns expected output" {
    run parse_headers < test/fixtures/header-content-length-only
    test "$status" -eq 0
    test "$output" = "123"
}

@test "get_method returns initialize" {
    run get_method < test/fixtures/method/initialize
    test "$status" -eq 0
    test "$output" = "initialize"
}
