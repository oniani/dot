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
        vim.cmd.wincmd { args = { "=" } }
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    desc = "Sets `makeprg` based on filetype",
    group = vim.api.nvim_create_augroup("set-makeprg", { clear = true }),
    pattern = "*",
    callback = function(ev)
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
        vim.opt_local.makeprg = ft_to_prg[ev.match] or "make"
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    desc = "Sets `formatprg` based on filetype",
    group = vim.api.nvim_create_augroup("set-formatprg", { clear = true }),
    pattern = {
        "css",
        "go",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "python",
        "rust",
        "sh",
        "typescript",
        "zsh",
    },
    callback = function(ev)
        local ft_to_fmt = {
            css = "prettier --parser css --print-width 100 --stdin-filepath",
            go = "gofmt",
            html = "prettier --parser html --print-width 100 --stdin-filepath",
            javascript = "prettier --parser babel --print-width 100 --stdin-filepath",
            json = "prettier --parser json --print-width 100 --stdin-filepath",
            lua = "stylua --call-parentheses None --column-width 100 --indent-type Spaces --indent-width 4 -",
            markdown = "prettier --parser markdown --print-width 100 --stdin-filepath",
            python = "ruff format --line-length 100 - && isort --profile black -",
            rust = "cargo fmt --emit=stdout --stdin",
            sh = "shfmt -filename %",
            typescript = "prettier --parser typescript --print-width 100 --stdin-filepath",
            zsh = "shfmt -filename %",
        }
        vim.opt_local.formatprg = ft_to_fmt[ev.match] or ""
    end,
})
