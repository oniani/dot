-- Author: David Oniani <onianidavid@gmail.com>
-- License: MIT
-- Description: Neovim configuration file

require("nvim-treesitter.configs").setup {
    ensure_installed = {
        "bash",
        "c",
        "comment",
        "cpp",
        "css",
        "diff",
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
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<C-space>",
            node_decremental = "<BS>",
            node_incremental = "<C-space>",
            scope_incremental = false,
        },
    },
}
