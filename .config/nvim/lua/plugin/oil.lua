return {
    "stevearc/oil.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    opts = {
        skip_confirm_for_simple_edits = true,
        view_options = {
            show_hidden = true,
        },
    },
    keys = {
        { "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
    },
}
