return {
    "nvim-treesitter/nvim-treesitter",
    opts = {
        ensure_installed = {
            "bash",
            "c",
            "css",
            "diff",
            "html",
            "javascript",
            "lua",
            "luadoc",
            "markdown",
            "python",
            "rust",
            "typescript",
            "vim",
            "vimdoc",
        },
        highlight = { enable = true, additional_vim_regex_highlighting = false },
        indent = { enable = true },
    },
}
