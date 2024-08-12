return {
    "stevearc/conform.nvim",
    lazy = true,
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
        formatters_by_ft = {
            css = { "prettier" },
            html = { "prettier" },
            javascript = { "prettier" },
            json = { "prettier" },
            lua = { "stylua" },
            markdown = { "prettier" },
            nix = { "nixpkgs_fmt" },
            python = { "isort", "ruff_format" },
            sh = { "shfmt" },
            typescript = { "prettier" },
        },
        formatters = {
            prettier = { prepend_args = { "--print-width", "100" } },
            ruff_format = { append_args = { "--line-length", "100" } },
            shfmt = { prepend_args = { "--indent", "4" } },
            stylua = {
                prepend_args = {
                    "--column-width",
                    "100",
                    "--indent-type",
                    "spaces",
                    "--call-parentheses",
                    "None",
                },
            },
        },
    },
    init = function()
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

        vim.api.nvim_create_user_command("F", function()
            require("conform").format { async = true, lsp_format = "fallback" }
        end, { desc = "[F]ormat" })
    end,
}
