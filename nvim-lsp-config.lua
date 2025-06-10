
vim.lsp.config.kconfig = {
    root_markers = { '.git' },
    cmd = { '/home/kin/src/kconfig-language-server/kconfig-language-server' },
    filetypes = { 'kconfig' },
}

vim.lsp.enable('kconfig')
