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
require("general.mappings")
require("general.options")

-- Packer and plugins
require("plugins.packer")
require("plugins.lualine")
require("plugins.neogit")
require("plugins.nvimtree")
require("plugins.telescope")
require("plugins.tokyonight")
require("plugins.treesitter")

-- Language server and related settings
require("plugins.lsp.compe")
require("plugins.lsp.config")
require("plugins.lsp.kinds")
