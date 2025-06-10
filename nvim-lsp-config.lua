
vim.lsp.config.kconfig = {
    root_markers = { '.git' },
    cmd = { 'kconfig-language-server' },
    filetypes = { 'kconfig' },
}

vim.lsp.enable('kconfig')
