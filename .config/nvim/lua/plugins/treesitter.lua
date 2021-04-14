-- Neovim Treesitter settings
require("nvim-treesitter.configs").setup {
    highlight = {
        -- Set to `false` in order to disable the whole extension
        enable = true,
        -- List of language that will be disabled
        disable = { },
    },
    -- One of "all", "maintained", "language", or a list of languages
    ensure_installed = "maintained"
}
