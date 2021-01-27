-- Set the colorscheme
vim.api.nvim_command("colorscheme gruvbox8_hard")

-- Remove the background of `CursorLineNR` attribute
vim.cmd [[ augroup TransparentCursorLineNRBackground ]]
vim.cmd [[     autocmd! ]]
vim.cmd [[     autocmd ColorScheme * hi! CursorLineNR guibg=none ]]
vim.cmd [[ augroup END ]]
