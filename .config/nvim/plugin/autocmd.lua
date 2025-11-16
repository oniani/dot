-- Author: David Oniani <onianidavid@gmail.com>
-- Description: Neovim configuration file
-- License: MIT

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

vim.api.nvim_create_autocmd("VimResized", {
    desc = "Equalize splits when resized",
    group = vim.api.nvim_create_augroup("resize-window", { clear = true }),
    pattern = "*",
    callback = function()
        vim.cmd "wincmd ="
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    desc = "Sets `makeprg` based on filetype",
    group = vim.api.nvim_create_augroup("set-makeprg", { clear = true }),
    pattern = { "c", "cpp", "go", "haskell", "python", "rust", "sh", "tex", "zsh" },
    callback = function()
        local ft_to_prg = {
            c = "gcc '%' -o '%<' && './%<'",
            cpp = "clang++ -std=c++23 '%' -o '%<' && './%<'",
            go = "go",
            haskell = "runhaskell '%'",
            python = "python3 '%'",
            rust = "cargo",
            sh = "chmod +x '%' && ./'%'",
            tex = "latexmk -interaction=nonstopmode -pdf -outdir=target '%'",
            zsh = "zsh '%'",
        }
        local ft = vim.bo.filetype
        vim.opt_local.makeprg = ft_to_prg[ft] or "make"
    end,
})
