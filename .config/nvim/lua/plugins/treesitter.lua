-- Neovim Treesitter settings

-- Use utiliies
local util = require("util")

-- Set up treesitter
require('nvim-treesitter.configs').setup {
    highlight = {
        -- false will disable the whole extension
        enable = true,
        -- list of language that will be disabled
        disable = {},
    },
    playground = {
        enable = true,
        disable = { },
        -- Debounced time for highlighting nodes in the playground from source
        -- code
        updatetime = 25,
        -- Whether the query persists across vim sessions
        persist_queries = false
    },
    query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = {"BufWrite", "CursorHold"},
    },
    -- one of 'all', 'maintained', 'language', or a list of languages
    ensure_installed = 'all'
}

util.nmap("<Leader>t", ":TSPlaygroundToggle<CR>")
