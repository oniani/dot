-- Language Server Client (LSP) settings

-- Use utiliies
local util = require("util")

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
-- NOTE: Use command ":verbose imap <TAB>" to make sure tab is not mapped by
--       other plugin before putting this into your config.
function _G.check_back_space()
    local col = vim.fn.col(".") - 1
    if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
        return true
    end
    return false
end

-- Use the <TAB> key properly
util.imap("<TAB>", "pumvisible() ? \"<C-N>\" : v:lua.check_back_space() ? \"<TAB>\" : coc#refresh()", { expr = true })
util.imap("<S-TAB>", "pumvisible() ? \"<C-P>\" : \"<C-H>\"", { expr = true })

-- Show documentation
function show_documentation()
    local cw = vim.fn.expand("<cword>")
    if vim.fn.index({"vim", "help"}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command("h "..cw)
    elseif vim.api.nvim_eval("coc#rpc#ready()") then
        vim.fn.CocActionAsync("doHover")
    else
        vim.api.nvim_command("!"..vim.o.keywordprg.." "..cw)
    end
end

-- Use K to show documentation in a preview window
util.nmap("K", "<CMD>lua show_documentation()<CR>")

-- Code navigation
util.nmap("gd", "<Plug>(coc-definition)", { noremap = false })
util.nmap("gi", "<Plug>(coc-implementation)", { noremap = false })
util.nmap("gr", "<Plug>(coc-references)", { noremap = false })
util.nmap("gy", "<Plug>(coc-type-definition)", { noremap = false })

-- Diagnostics navigation
util.nmap("ge", "<Plug>(coc-diagnostic-next)", { noremap = false })
util.nmap("gE", "<Plug>(coc-diagnostic-prev)", { noremap = false })

-- Diagnostics window
util.nmap("md", ":<C-u>CocList diagnostics<CR>", { nowait = true })

-- -- Marketplace window
util.nmap("mm", ":<C-u>CocList marketplace<CR>", { nowait = true })

-- Symbol renaming
util.nmap("ms", "<Plug>(coc-rename)", { noremap = false })

-- Format the current buffer
vim.api.nvim_command([[ command! -nargs=0 Format :call CocAction("format") ]])
