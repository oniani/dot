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
    "general",
    "autocmds",
    "mappings",
    "plugins",
    "plugins/colorscheme",
    "plugins/fzf",
    "plugins/lsp",
    "plugins/statusline",
    "plugins/treesitter"
}

for _, filename in ipairs(filenames) do
    require(filename)
end
