-- Author: David Oniani <onianidavid@gmail.com>
-- Description: Neovim configuration file
-- License: MIT

--- Attach Treesitter features to a buffer if a parser is available.
---
--- Registers the language, starts the parser, and configures indent and fold
--- expressions for the buffer/window.
---
--- @param buf number Buffer handle
--- @param lang string Treesitter language name
local function try_attach(buf, lang)
    if not vim.treesitter.language.add(lang) then
        return
    end

    vim.treesitter.start(buf, lang)

    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
end

--- Handle FileType events to attach Treesitter.
---
--- Determines the Treesitter language for the filetype and:
--- - Attaches immediately if the parser is installed
--- - Installs and then attaches if the parser is available
--- - Falls back to attempting attachment for custom/external parsers
vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
        local buf, filetype = args.buf, args.match
        local lang = vim.treesitter.language.get_lang(filetype)
        if not lang then
            return
        end

        local installed_parsers = require("nvim-treesitter").get_installed "parsers"
        local available_parsers = require("nvim-treesitter").get_available()
        if vim.tbl_contains(installed_parsers, lang) then
            try_attach(buf, lang)
        elseif vim.tbl_contains(available_parsers, lang) then
            require("nvim-treesitter").install(lang):await(function()
                try_attach(buf, lang)
            end)
        else
            try_attach(buf, lang)
        end
    end,
})

--- Ensure a baseline set of Treesitter parsers is installed.
---
--- Modify this list to match the languages you commonly use.
require("nvim-treesitter").install {
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
}
