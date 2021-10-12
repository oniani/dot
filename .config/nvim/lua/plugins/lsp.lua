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
local function make_config(server, on_attach, engine)
    local capabilities = engine.update_capabilities(vim.lsp.protocol.make_client_capabilities())
    local config = { capabilities = capabilities, on_attach = on_attach }
    if server == "efm" then
        config.filetypes = vim.fn.keys(efm_settings.languages)
        config.init_options = { documentFormatting = true }
        config.settings = efm_settings
    elseif server == "rust_analyzer" then
        config.settings = rust_analyzer_settings
    end
    return config
end

-- Icons
local kinds = {
    Class = "ﴯ Class",
    Color = " Color",
    Constant = " Constant",
    Constructor = " Constructor",
    Enum = " Enum",
    EnumMember = " Enum-member",
    Event = " Event",
    Field = "ﰠ Field",
    File = " File",
    Folder = " Folder",
    Fun = " Fun",
    Interface = " Interface",
    Keyword = " Keyword",
    Method = " Method",
    Module = " Module",
    Operator = " Operator",
    Property = "ﰠ Property",
    Reference = " Reference",
    Snippet = "﬌ Snippet",
    Struct = "פּ Struct",
    Text = " Text",
    TypeParameter = " Type-param",
    Unit = " Unit",
    Value = " Value",
    Var = " Var",
}

-- Set up nvim-cmp
local cmp = require("cmp")
cmp.setup({
    mapping = {
        ["<C-o>"] = cmp.mapping.complete(),
        ["<C-c>"] = cmp.mapping.close(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-u>"] = cmp.mapping.scroll_docs(4),
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
    sources = { { name = "buffer" }, { name = "nvim_lsp" }, { name = "path" } },
    formatting = {
        format = function(_, vim_item)
            vim_item.kind = kinds[vim_item.kind]
            return vim_item
        end,
    },
    experimental = { ghost_text = true },
})

-- Use LSP configurations to set up the servers
local lspconfig = require("lspconfig")
local servers = { "bashls", "clangd", "cmake", "efm", "gopls", "pyright", "rust_analyzer" }
for _, server in ipairs(servers) do
    lspconfig[server].setup(make_config(server, on_attach, require("cmp_nvim_lsp")))
end
