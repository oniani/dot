-- Access Vim API
api = vim.api

-- Allow for defining autocommands
function _G.augroups(definitions)
    for group_name, definition in pairs(definitions) do
        api.nvim_command("augroup " .. group_name)
        api.nvim_command("autocmd!")
        for _, def in ipairs(definition) do
            local command = table.concat(vim.tbl_flatten {"autocmd", def}, " ")
            api.nvim_command(command)
        end
        api.nvim_command("augroup END")
    end
end

-- Define all autocommands
local autocmds = {
    TexClean = {
        { "VimLeave", "*.tex", ":!texclean" }
    },
    LuaHighlight = {
        { "TextYankPost", "*", "silent! lua vim.highlight.on_yank { }" }
    },
    TransparentBackground = {
        { "ColorScheme", "*", "hi! Normal ctermbg=none guibg=none"  }
    },
    ItalicCommments = {
        { "ColorScheme", "*", "hi! Comment cterm=italic gui=italic" }
    }
}

-- Activate all autocommands
augroups(autocmds)
