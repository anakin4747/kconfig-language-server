
# Kconfig LSP

A minimal language server for the Kconfig language used for build system
configuration in many notable projects such as Linux, U-Boot, and Zephyr.

The language server should generally work in all of these projects and is
mainly intended for using in Kconfig files.

Future support for Kconfig symbols in C, .config, defconfigs, and etc. is
desired but not yet implemented.

This project mainly provides documentation for most tokens in Kconfig files but
hopes to support most LSP methods in the future when I have time to work on it.

The documentation provided by the `hover` LSP method is provided by
`Documentation/kbuild/kconfig-language.rst` if available otherwise is provided
by the `kconfig-language.rst` that gets installed with this language server.
The purpose of this is to try to rely on the most relevant documentation.

An indication (at least in my Neovim config) to where the documentation came
from is if the hover is colourful. The `kconfig-language.rst` document provided
by this repo wraps all Kconfig snippets in markdown to identify it. The
language server protocol uses markdown for the `hover` method. My editor picks
up these code blocks and colours them. However, if the documentation was found
in the repo, it will contain no markdown code blocks (since it is .rst) and my
editor does not colour them.

The `kconfig-language.rst` file is derived from the file of the same name in
the Linux kernel source code so this code base is also made available under
GPL-2.0 (see LICENSE).

## Demo

<div align="center">

[![Demo of kconfig-language-server](https://img.youtube.com/vi/N20begB_v9s/mqdefault.jpg)](https://www.youtube.com/watch?v=N20begB_v9s)

</div>

## Dependencies

This application relys on several command line tools, make sure you have
installed:
- rg
- jq
- awk
- sed
- bats (optional, for testing)

## Installation

Being a single file bash script no building is required and installation is
straight-forward. A `Makefile` is provided for easy installation.

```sh
sudo make install
# or
sudo make dev-install # for installing as a symlink
# and
sudo make uninstall # for uninstalling
```

## Testing

This application is tested with `bats` test framework and ideally features
should be added in the future following TDD practices.

```sh
make
# or
make test
```

Note that some tests may be failing for features I have yet to add.

## Configuration

### Neovim

```lua
vim.lsp.config.kconfig = {
    root_markers = { '.git' },
    cmd = { 'kconfig-language-server' },
    filetypes = { 'kconfig' },
}

vim.lsp.enable('kconfig')
```

## Troubleshooting

If the `kconfig-language-server` fails immediately, this may be due to missing
dependencies or other issues. The language server may print an explanation on
stdout. Running the language server by itself may print the error. If it just
hangs and prints no output then it likely started fine. If it prints an error
you can use that to see what caused the error. Its a very small application so
reading it will likely be the fastest solution to your issue.

```sh
kconfig-language-server
```

## Supported LSP Methods

| Method | Supported | Comment |
|--------|-----------|---------|
|textDocument/hover|true||
|textDocument/definition|false|Higher priority feature|
|textDocument/completion|false|Higher priority feature|
|textDocument/references|false|Higher priority feature|
|textDocument/rename|false|Higher priority feature|
|textDocument/diagnostic|false|Higher priority feature|
|callHierarchy/incomingCalls|false|Higher priority feature|
|callHierarchy/outgoingCalls|false|Higher priority feature|
|textDocument/codeAction|false|Not a priority|
|textDocument/declaration|false|Not a priority|
|textDocument/documentHighlight|false|Not a priority|
|textDocument/documentSymbol|false|Not a priority|
|textDocument/foldingRange|false|Not a priority|
|textDocument/formatting|false|Not a priority|
|textDocument/implementation|false|Not a priority|
|textDocument/inlayHint|false|Not a priority|
|textDocument/prepareTypeHierarchy|false|Not a priority|
|textDocument/publishDiagnostics|false|Not a priority|
|textDocument/rangeFormatting|false|Not a priority|
|textDocument/rangesFormatting|false|Not a priority|
|textDocument/semanticTokens/full|false|Not a priority|
|textDocument/semanticTokens/full/delta|false|Not a priority|
|textDocument/signatureHelp|false|Not a priority|
|textDocument/typeDefinition|false|Not a priority|
|typeHierarchy/subtypes|false|Not a priority|
|typeHierarchy/supertypes|false|Not a priority|
|window/logMessage|false|Not a priority|
|window/showMessage|false|Not a priority|
|window/showDocument|false|Not a priority|
|window/showMessageRequest|false|Not a priority|
|workspace/applyEdit|false|Not a priority|
|workspace/configuration|false|Not a priority|
|workspace/executeCommand|false|Not a priority|
|workspace/inlayHint/refresh|false|Not a priority|
|workspace/symbol|false|Not a priority|
|workspace/workspaceFolders|false|Not a priority|

