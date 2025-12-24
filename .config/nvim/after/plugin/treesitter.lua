-- Author: David Oniani <onianidavid@gmail.com>
-- Description: Neovim configuration file
-- License: MIT

require("nvim-treesitter.config").setup {
    ensure_installed = {
        "bash",
        "c",
        "comment",
        "cpp",
        "css",
        "diff",
        "go",
        "html",
        "javascript",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "rust",
        "sql",
        "typescript",
        "vim",
        "vimdoc",
    },
    highlight = { enable = true },
    indent = { enable = true },
}
