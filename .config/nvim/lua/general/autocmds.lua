-- Equalize splits when resized
vim.api.nvim_exec(
	[[
    augroup AutoResize
        autocmd!
        autocmd VimResized * wincmd =
    augroup end
]],
	false
)

-- Highlight on yank
vim.api.nvim_exec(
	[[
    augroup YankHighlight
        autocmd!
        autocmd TextYankPost * silent! lua vim.highlight.on_yank()
    augroup end
]],
	false
)
