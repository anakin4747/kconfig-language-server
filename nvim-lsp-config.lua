
vim.lsp.config.kconfig = {
    root_markers = { '.git' },
    cmd = { '/home/kin/src/kconfig-lsp/kconfig-lsp.sh' },
    filetypes = { 'kconfig' },
}

vim.lsp.enable('kconfig')
