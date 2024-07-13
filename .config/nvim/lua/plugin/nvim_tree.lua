return {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    version = "*",
    lazy = false,
    config = function()
        require("nvim-tree").setup {}
        vim.keymap.set("n", "<C-n>", function()
            require "nvim-tree.api".tree.toggle({ focus = false })
        end)
    end,
}
