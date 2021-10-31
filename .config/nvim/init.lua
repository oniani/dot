--
-- Author: David Oniani
--
--  _       _ _     _
-- (_)_ __ (_) |_  | |_   _  __ _
-- | | '_ \| | __| | | | | |/ _` |
-- | | | | | | |_ _| | |_| | (_| |
-- |_|_| |_|_|\__(_)_|\__,_|\__,_|
--
-- Plugin-independent, general settings
require("general.autocmds")
require("general.colorscheme")
require("general.mappings")
require("general.options")

-- Packer and plugins
require("plugins.packer")
require("plugins.fzf")
require("plugins.lsp")
require("plugins.neogit")
require("plugins.treesitter")
