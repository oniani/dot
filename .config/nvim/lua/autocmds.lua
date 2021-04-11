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
    ItalicCommments = {
        { "ColorScheme", "*", "hi! Comment cterm=italic gui=italic" }
    },
    LuaHighlight = {
        { "TextYankPost", "*", "silent! lua vim.highlight.on_yank { }" }
    },
    TexClean = {
        { "VimLeave", "*.tex", ":!texclean" }
    },
    TransparentBackground = {
        { "ColorScheme", "*", "hi! Normal ctermbg=none guibg=#12131a"  }
    }
}

-- Activate all autocommands
augroups(autocmds)
