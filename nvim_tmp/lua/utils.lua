-- Contents of the utilities module
local util = {}

-- Simplify definitions
local api = vim.api
local cmd = vim.cmd

-- Normal mode keymapping function
function util.nmap(command, value)
    api.nvim_set_keymap('n', command, value, { noremap = true, silent = true })
end

-- Insert mode keymapping function
function util.imap(command, value)
    api.nvim_set_keymap('i', command, value, { noremap = true, silent = true })
end

-- Visual mode keymapping function
function util.vmap(command, value)
    api.nvim_set_keymap('v', command, value, { noremap = true, silent = true })
end

-- Terminal mode keymapping function
function util.tmap(command, value)
    api.nvim_set_keymap('t', command, value, { noremap = true, silent = true })
end

-- An implementation of a generic `set` function
function set(key, val, opt)
    if key ~= nil and val == nil and opt == nil then
        cmd(string.format('set %s', key))
    elseif key ~= nil and val ~= nil and opt == nil then
        cmd(string.format('set %s=%s', key, val))
    elseif key ~= nil and val ~= nil and opt ~= nil then
        cmd(string.format('set %s%s=%s', key, opt, val))
    end
end

-- Make the module exportable
return util
