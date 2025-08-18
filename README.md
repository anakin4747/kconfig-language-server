
# Kconfig LSP

Currently only supports hover.

Will use kconfig documentation if available in current `rootPath` else will
resort to documentation in kconfig-language.rst

## Dependencies

This application relys on several command line tools, make sure you have
installed:
- rg
- jq
- awk
- sed

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

