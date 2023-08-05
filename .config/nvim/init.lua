-- Neovim configuration file
-- by David Oniani <onianidavid@gmail.com>
-- License: MIT License

-- Perf
vim.g.did_install_default_menus = 1
vim.g.loaded_gzip = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.python3_host_prog = "/home/oniani/.local/share/pyenv/shims/python"
vim.loader.enable()

-- Setup
require "autocmd"
require "keymap"
require "option"
require "plugin"
