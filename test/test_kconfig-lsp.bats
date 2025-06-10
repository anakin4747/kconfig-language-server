#!/usr/bin/env bats

setup() {
    source kconfig-language-server
}

@test "parse_headers returns expected output" {
    run parse_headers < test/fixtures/header-content-length-only
    test "$status" -eq 0
    test "$output" = "123"
}

@test "get_cword gets all keywords" {
    run get_cword 2 1 test/fixtures/Kconfig
    test "$status" -eq 0
    test "$output" = "config"

    run get_cword 3 2 test/fixtures/Kconfig
    test "$status" -eq 0
    test "$output" = "string"

    run get_cword 4 2 test/fixtures/Kconfig
    test "$status" -eq 0
    test "$output" = "depends"

    run get_cword 5 2 test/fixtures/Kconfig
    test "$status" -eq 0
    test "$output" = "option"

    run get_cword 6 2 test/fixtures/Kconfig
    test "$status" -eq 0
    test "$output" = "default"

    run get_cword 13 2 test/fixtures/Kconfig
    test "$status" -eq 0
    test "$output" = "def_bool"

    run get_cword 41 2 test/fixtures/Kconfig
    test "$status" -eq 0
    test "$output" = "help"

    run get_cword 75 1 test/fixtures/Kconfig
    test "$status" -eq 0
    test "$output" = "menu"

    run get_cword 56 2 test/fixtures/Kconfig
    test "$status" -eq 0
    test "$output" = "bool"

    run get_cword 86 2 test/fixtures/Kconfig
    test "$status" -eq 0
    test "$output" = "int"

    run get_cword 179 1 test/fixtures/Kconfig
    test "$status" -eq 0
    test "$output" = "choice"

    run get_cword 180 1 test/fixtures/Kconfig
    test "$status" -eq 0
    test "$output" = "prompt"

    run get_cword 271 1 test/fixtures/Kconfig
    test "$status" -eq 0
    test "$output" = "endchoice"

    run get_cword 422 2 test/fixtures/Kconfig
    test "$status" -eq 0
    test "$output" = "select"

    run get_cword 584 2 test/fixtures/Kconfig
    test "$status" -eq 0
    test "$output" = "tristate"

    run get_cword 585 2 test/fixtures/Kconfig
    test "$status" -eq 0
    test "$output" = "---help---"

    run get_cword 613 2 test/fixtures/Kconfig
    test "$status" -eq 0
    test "$output" = "range"

    run get_cword 750 2 test/fixtures/Kconfig
    test "$status" -eq 0
    test "$output" = "endmenu"
}

@test "get_docs returns expected output" {
    export ROOTPATH=
    run get_docs "config"
    test "$status" -eq 0
    [[ "$output" =~ "Menu entries" ]]
    [[ ! "$output" =~ "Menu attributes" ]]
}
