-- Options to be set when attaching a language server
local on_attach = function(client, bufnr)
    local function keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local opts = { noremap = true, silent = true }

    keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
    keymap("n", "T", "<Cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    keymap("n", "cn", "<Cmd>lua vim.lsp.buf.rename()<CR>", opts)
    keymap("n", "dl", "<Cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
    keymap("n", "dn", "<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
    keymap("n", "dp", "<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
    keymap("n", "dr", "<Cmd>lua vim.lsp.buf.references()<CR>", opts)
    keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)

    if client.resolved_capabilities.document_formatting then
        vim.api.nvim_exec(
            [[
            augroup AutoFormat
                autocmd!
                autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting_sync()
            augroup END
        ]],
            false
        )
    end
end

-- Configure efm language server
local efm_settings = {
    rootMarkers = { ".git/" },
    languages = {
        json = { { formatCommand = "prettier --tab-width 4 --stdin-filepath ${INPUT}", formatStdin = true } },
        lua = { { formatCommand = "stylua --indent-type Spaces -", formatStdin = true } },
        markdown = { { formatCommand = "prettier --tab-width 4 --stdin-filepath ${INPUT}", formatStdin = true } },
        python = { { formatCommand = "black -", formatStdin = true } },
    },
}

-- Configure rust_analyzer language server
local rust_analyzer_settings = {
    ["rust-analyzer"] = {
        checkOnSave = {
            allFeatures = true,
            overrideCommand = {
                "cargo",
                "clippy",
                "--all-features",
                "--all-targets",
                "--message-format=json",
                "--workspace",
            },
        },
    },
}

-- Makes a custom config with the snippet support
local function make_config(server_name, on_attach, engine)
    local capabilities = engine.update_capabilities(vim.lsp.protocol.make_client_capabilities())
    local config = { capabilities = capabilities, on_attach = on_attach }
    if server_name == "efm" then
        config.filetypes = vim.fn.keys(efm_settings.languages)
        config.init_options = { documentFormatting = true }
        config.settings = efm_settings
    elseif server_name == "rust_analyzer" then
        config.settings = rust_analyzer_settings
    end
    return config
end

-- Set up nvim-cmp
local cmp = require("cmp")
local lspkind = require("lspkind")

cmp.setup({
    experimental = { ghost_text = true },
    formatting = {
        format = lspkind.cmp_format({
            with_text = true,
            menu = {
                nvim_lsp = "[LSP]",
                buffer = "[Buffer]",
                path = "[PATH]",
                latex_symbols = "[LaTeX]",
            },
        }),
    },
    mapping = {
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-u>"] = cmp.mapping.scroll_docs(4),
        ["<C-o>"] = cmp.mapping.complete(),
        ["<C-c>"] = cmp.mapping.close(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
        ["<Tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end,
        ["<S-Tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end,
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
    },
})

-- Use LSP configurations to set up the servers
local lsp_installer = require("nvim-lsp-installer")
local lspconfig = require("lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")

local server_names = { "bashls", "clangd", "cmake", "efm", "gopls", "pyright", "rust_analyzer" }
for _, server_name in ipairs(server_names) do
    local ok, server = lsp_installer.get_server(server_name)
    if ok then
        if not server:is_installed() then
            server:install()
        end
    end
    lspconfig[server_name].setup(make_config(server_name, on_attach, cmp_nvim_lsp))
end
