-- Access Nvim API and functions
local api = vim.api
local fn  = vim.fn

-- Set up `nvim-compe`
require("compe").setup {
    autocomplete = true,
    debug = false,
    documentation = true,
    enabled = true,
    incomplete_delay = 400,
    max_abbr_width = 100,
    max_kind_width = 100,
    max_menu_width = 100,
    min_length = 1,
    preselect = "enable",
    source_timeout = 200,
    throttle_time = 80,

    source = {
        buffer = {
            menu = " Buffer",
        },
        calc = true,
        nvim_lsp = true,
        nvim_lua = true,
        path = true,
        snippets_nvim = true,
        spell = {
            menu = " Spell"
        },
        tags = false,
        treesitter = true,
        vsnip = false
    }
}

-- Check a back space
local check_back_space = function()
    local col = fn.col(".") - 1
    if col == 0 or fn.getline("."):sub(col, col):match("%s") then
        return true
    end
    return false
end

-- Use <C-n>/<Tab> to:
--     * Move to next item in completion menuone
--     * Jump to next snippet's placeholder
_G.tab_complete = function()
    if fn.pumvisible() == 1 then
        return api.nvim_replace_termcodes("<C-n>", true, true, true)
    end
    if check_back_space() then
        return api.nvim_replace_termcodes("<Tab>", true, true, true)
    end
    return fn["compe#complete"]()
end

-- Use <C-p>/<S-Tab> to:
--     * Move to previous item in completion menuone
--     * Jump to previous snippet's placeholder
_G.s_tab_complete = function()
    if fn.pumvisible() == 1 then
        return api.nvim_replace_termcodes("<C-p>", true, true, true)
    end
    return api.nvim_replace_termcodes("<S-Tab>", true, true, true)
end

-- Set up the mappings
api.nvim_set_keymap("i", "<Tab>",   "v:lua.tab_complete()",   {expr = true})
api.nvim_set_keymap("s", "<Tab>",   "v:lua.tab_complete()",   {expr = true})
api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
