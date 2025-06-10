#!/usr/bin/env bats

setup() {
    source kconfig-language-server
}

@test "parse_headers returns expected output" {
    run parse_headers < test/fixtures/header-content-length-only
    test "$status" -eq 0
    test "$output" = "123"
}

