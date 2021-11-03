vim.api.nvim_command([[
autocmd BufWinEnter *.nix :LspStart rnix
]])
