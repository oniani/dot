--
-- Author: David Oniani
--
--  _       _ _     _
-- (_)_ __ (_) |_  | |_   _  __ _
-- | | '_ \| | __| | | | | |/ _` |
-- | | | | | | |_ _| | |_| | (_| |
-- |_|_| |_|_|\__(_)_|\__,_|\__,_|
--

-- General settings
require("general.autocmds")
require("general.mappings")
require("general.options")

-- Plugin settings
require("plugins.packer")
require("plugins.lsp")

require("kanagawa").setup({ colors = { bg = "#0e0e11" } })
vim.cmd("colorscheme kanagawa")
