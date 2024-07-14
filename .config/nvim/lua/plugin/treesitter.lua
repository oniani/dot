return {
    "nvim-treesitter/nvim-treesitter",
    -- Last release is way too old and doesn't work on Windows
    version = false,
    build = ":TSUpdate",
    event = { "LazyFile", "VeryLazy" },
    -- Load treesitter early when opening a file from the cmdline
    lazy = vim.fn.argc(-1) == 0,
    init = function(plugin)
        -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
        -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
        -- no longer trigger the **nvim-treesitter** module to be loaded in time.
        -- Luckily, the only things that those plugins need are the custom queries, which we make
        -- available during startup.
        require("lazy.core.loader").add_to_rtp(plugin)
        require("nvim-treesitter.query_predicates")
    end,
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    keys = {
        { "<c-space>", desc = "Increment Selection" },
        { "<bs>",      desc = "Decrement Selection", mode = "x" },
    },
    opts_extend = { "ensure_installed" },
    opts = {
        ensure_installed = {
            "bash",
            "c",
            "css",
            "diff",
            "html",
            "javascript",
            "lua",
            "luadoc",
            "markdown",
            "python",
            "rust",
            "sql",
            "typescript",
            "vim",
            "vimdoc",
        },
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<C-space>",
                node_incremental = "<C-space>",
                scope_incremental = false,
                node_decremental = "<bs>",
            },
        },
    },
    config = function(_, opts)
        if type(opts.ensure_installed) == "table" then
            opts.ensure_installed = LazyVim.dedup(opts.ensure_installed)
        end
        require("nvim-treesitter.configs").setup(opts)
    end,
}
