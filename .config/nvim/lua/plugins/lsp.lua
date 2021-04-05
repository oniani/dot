-- Language Server Client (LSP) settings

-- Access Vim API and functions
api = vim.api
fn = vim.fn

-- List of CoC extensions to be automatically installed
vim.g.coc_global_extensions = {
    "coc-clangd",
    "coc-git",
    "coc-go",
    "coc-json",
    "coc-lua",
    "coc-marketplace",
    "coc-pyright",
    "coc-rust-analyzer",
    "coc-texlab",
    "coc-tsserver"
}

-- Use tab for trigger completion with characters ahead and navigate.
function _G.check_back_space()
    local col = fn.col(".") - 1
    if col == 0 or fn.getline("."):sub(col, col):match("%s") then
        return true
    end
    return false
end

-- Use the <TAB> key to trigger the completion and navigate the completion list
-- NOTE: Use command ":verbose imap <TAB>" to make sure tab is not mapped by
--       other plugin before putting this into your config.
api.nvim_set_keymap(
    "i",
    "<TAB>",
    "pumvisible() ? \"<C-N>\" : v:lua.check_back_space() ? \"<TAB>\" : coc#refresh()",
    { silent = true, expr = true }
)
api.nvim_set_keymap(
    "i",
    "<S-TAB>",
    "pumvisible() ? \"<C-P>\" : \"<C-H>\"",
    { expr = true }
)

-- Show documentation
function _G.show_docs()
    local cw = fn.expand("<cword>")
    if fn.index({"vim", "help"}, vim.bo.filetype) >= 0 then
        api.nvim_command("h " .. cw)
    elseif api.nvim_eval("coc#rpc#ready()") then
        fn.CocActionAsync("doHover")
    else
        api.nvim_command("!" .. vim.o.keywordprg .. " " .. cw)
    end
end

-- Use K to show documentation in a preview window
api.nvim_set_keymap(
    "n",
    "K",
    "<CMD>lua show_docs()<CR>",
    { noremap = true }
)

-- Code navigation
api.nvim_set_keymap(
    "n",
    "gd",
    "<Plug>(coc-definition)",
    { silent = true }
)
api.nvim_set_keymap(
    "n",
    "gi",
    "<Plug>(coc-implementation)",
    { silent = true }
)
api.nvim_set_keymap(
    "n",
    "gr",
    "<Plug>(coc-references)",
    { silent = true }
)
api.nvim_set_keymap(
    "n",
    "gy",
    "<Plug>(coc-type-definition)",
    { silent = true }
)

-- Diagnostics navigation
api.nvim_set_keymap(
    "n",
    "ge",
    "<Plug>(coc-diagnostic-next)",
    { silent = true }
)
api.nvim_set_keymap(
    "n",
    "gE",
    "<Plug>(coc-diagnostic-prev)",
    { silent = true }
)

-- Diagnostics window
api.nvim_set_keymap(
    "n",
    "md",
    ":<C-u>CocList diagnostics<CR>",
    { noremap = true, nowait = true, silent = true }
)

-- Marketplace window
api.nvim_set_keymap(
    "n",
    "mm",
    ":<C-u>CocList marketplace<CR>",
    { noremap = true, nowait = true, silent = true }
)

-- Symbol renaming
api.nvim_set_keymap(
    "n",
    "ms",
    "<Plug>(coc-rename)",
    { }
)

-- Format the current buffer
api.nvim_command([[ command! -nargs=0 Format :call CocAction("format") ]])
