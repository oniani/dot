-- Contents of the utilities module
local util = {}

-- Simplify definitions
local api = vim.api

-- Normal mode keymapping function
function util.nmap(key, cmd, opts)
    -- NOTE: this is a trick to make `opts` an optional argument
    opts = vim.tbl_extend("keep", opts or { }, {
        noremap = true,
        silent = true
    })

    api.nvim_set_keymap("n", key, cmd, opts)
end

-- Insert mode keymapping function
function util.imap(key, cmd, opts)
    -- NOTE: this is a trick to make `opts` an optional argument
    opts = vim.tbl_extend("keep", opts or { }, {
        noremap = true,
        silent = true
    })

    api.nvim_set_keymap("i", key, cmd, opts)
end

-- An implementation of the generic `set` function
function util.set(key, val, opt)
    if key ~= nil and val == nil and opt == nil then
        api.nvim_command(string.format("set %s", key))
    elseif key ~= nil and val ~= nil and opt == nil then
        api.nvim_command(string.format("set %s=%s", key, val))
    elseif key ~= nil and val ~= nil and opt ~= nil then
        api.nvim_command(string.format("set %s%s=%s", key, opt, val))
    end
end

-- Make the module importable
return util
