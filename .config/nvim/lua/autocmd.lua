-- Defines groups
local auto_generate = vim.api.nvim_create_augroup("AutoGenerate", { clear = true })
local miscellaneous = vim.api.nvim_create_augroup("Miscellaneous", { clear = true })

-- Regenerates Graphviz file on write
vim.api.nvim_create_autocmd("BufWritePost *.dot", {
    command = "silent !dot -T png % -o %:r.png",
    group = auto_generate,
    pattern = "*.dot",
})

-- Regenerates LaTeX document on write
vim.api.nvim_create_autocmd("BufWritePost", {
    command = "silent !latexmk -interaction=nonstopmode -pdf -shell-escape %",
    group = auto_generate,
    pattern = "*.tex",
})

-- Equalizes splits when resized
vim.api.nvim_create_autocmd("VimResized *", {
    command = "wincmd =",
    group = miscellaneous,
    pattern = "*",
})

-- Highlights on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = miscellaneous,
    pattern = "*",
})
