--
-- Author: David Oniani
--
--  _       _ _     _
-- (_)_ __ (_) |_  | |_   _  __ _
-- | | '_ \| | __| | | | | |/ _` |
-- | | | | | | |_ _| | |_| | (_| |
-- |_|_| |_|_|\__(_)_|\__,_|\__,_|
--

-- List of lua modules
local filenames = {
    -- Plugin-independent, general settings
    "general/autocmds",
    "general/mappings",
    "general/options",

    -- Packer and plugins
    "plugins.packer",
    "plugins.dracula",
    "plugins.fzf",
    "plugins.indentblankline",
    "plugins.nvimtree",
    "plugins.statusline",
    "plugins.treesitter",
    "plugins.undotree",

    -- Language server and relates settings
    "plugins.lsp.compe",
    "plugins.lsp.lsp",
    "plugins.lsp.signs"
}

-- Iterate and set up all of the lua modules
for _, filename in ipairs(filenames) do
    require(filename)
end
