--
-- Author: David Oniani
--
--  _       _ _     _
-- (_)_ __ (_) |_  | |_   _  __ _
-- | | '_ \| | __| | | | | |/ _` |
-- | | | | | | |_ _| | |_| | (_| |
-- |_|_| |_|_|\__(_)_|\__,_|\__,_|
--

-- Autoinstall packer.nvim{{{

-- Specify path and repository
local path = vim.fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
local repo = "https://github.com/wbthomason/packer.nvim"

-- Clone packer.nvim
if vim.fn.empty(vim.fn.glob(path)) > 0 then
    vim.api.nvim_command(string.format("!git clone --depth 1 %s %s", repo, path))
end

-- Required since packer.nvim is in opt pack
vim.api.nvim_command("packadd packer.nvim")

-- }}}

-- Settings {{{

-- General settings
require("general.autocmds")
require("general.mappings")
require("general.options")

-- Plugin settings
require("plugins.lsp")
require("plugins.packer")

-- }}}
