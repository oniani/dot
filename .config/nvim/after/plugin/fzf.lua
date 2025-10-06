-- Author: David Oniani <onianidavid@gmail.com>
-- Description: Neovim configuration file
-- License: MIT

local fzf = require "fzf-lua"

vim.g.fzf_action = { ["ctrl-s"] = "split", ["ctrl-v"] = "vsplit" }

fzf.setup { keymap = { fzf = { ["ctrl-q"] = "select-all+accept" } } }

vim.keymap.set("n", "<C-g>", fzf.live_grep, { desc = "[Grep]" })
vim.keymap.set("n", "<C-p>", fzf.files, { desc = "[Files]" })

--- Resolves the directory from user input, expanding '~' and trimming spaces/quotes.
--- Falls back to the current directory if invalid.
---@param opts table: User arguments.
---@return string: Resolved or current directory.
local function get_cwd(opts)
    local cwd = vim.fn.trim(opts.args)
    cwd = vim.fn.expand(cwd)
    return cwd ~= "" and cwd or vim.fn.getcwd()
end

vim.api.nvim_create_user_command("Files", function(opts)
    fzf.files { cwd = get_cwd(opts) }
end, { desc = "[Files]", nargs = "?" })

vim.api.nvim_create_user_command("Grep", function(opts)
    fzf.live_grep { cwd = get_cwd(opts) }
end, { desc = "[Grep]", nargs = "?" })

vim.api.nvim_create_user_command("Commits", fzf.git_commits, { desc = "[Commits]" })
vim.api.nvim_create_user_command("Lines", fzf.lines, { desc = "[Lines]" })

vim.keymap.set("n", "gO", fzf.lsp_document_symbols, { desc = "Document Symbols" })
vim.keymap.set("n", "gr/", fzf.lsp_workspace_symbols, { desc = "Workspace Symbols" })
