-- Neovim Treesitter settings
require("nvim-treesitter.configs").setup {
    highlight = {
        -- false will disable the whole extension
        enable = true,
        -- list of language that will be disabled
        disable = { },
    },
    -- one of "all", "maintained", "language", or a list of languages
    ensure_installed = "maintained"
}
