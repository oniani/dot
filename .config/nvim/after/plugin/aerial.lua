require("aerial").setup({ layout = { min_width = 64 } })

vim.keymap.set("n", "<Leader>a", "<Cmd>AerialToggle<CR>", { noremap = true })
