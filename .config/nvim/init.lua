--
-- Author: David Oniani
--
--  _       _ _     _
-- (_)_ __ (_) |_  | |_   _  __ _
-- | | '_ \| | __| | | | | |/ _` |
-- | | | | | | |_ _| | |_| | (_| |
-- |_|_| |_|_|\__(_)_|\__,_|\__,_|
--

local filenames = {
    "autocmds",
    "general",
    "mappings",
    "plugins/colorscheme",
    "plugins/fzf",
    "plugins/lsp",
    "plugins/packer",
    "plugins/statusline",
    "plugins/treesitter"
}

for _, filename in ipairs(filenames) do
    require(filename)
end
