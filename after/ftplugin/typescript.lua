-- [nfnl] after/ftplugin/typescript.fnl
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.expandtab = true
return vim.lsp.enable("ts_ls")
