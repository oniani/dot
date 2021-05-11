-- Language Server Client (LSP) settings

-- Access LSP install and LSP configurations
local lspinstall = require("lspinstall")
local lspconfig  = require("lspconfig")

-- Access Nvim API and functions
local api = vim.api
local fn  = vim.fn

-- Set these options on language server attachment
local on_attach = function(client, bufnr)
    -- Convenient functions for setting keymaps and options
    local function keymap(...) api.nvim_buf_set_keymap(bufnr, ...) end
    local function option(...) api.nvim_buf_set_option(bufnr, ...) end

    -- Enable omni completion
    option("omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mapping options
    local opts = { noremap = true, silent = true }

    -- Mappings
    keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    keymap("n", "Ld", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
    keymap("n", "Lr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    keymap("n", "T", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    keymap("n", "nD", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
    keymap("n", "nd", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
    keymap("n", "nr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)

    -- If a language server has document formatting capabilities, format on save
    if client.resolved_capabilities.document_formatting then
        api.nvim_exec([[
            augroup Format
                autocmd!
                autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()
            augroup END
        ]], false)
    end
end

-- Configure lua language server for neovim development
local lua_settings = {
    Lua = {
        runtime = {
            -- LuaJIT in the case of Neovim
            version = "LuaJIT",
            -- Set up the Lua path
            path = vim.split(package.path, ";")
        },
        diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { "vim" },
        },
        workspace = {
            -- Make the server aware of Neovim runtime files
            library = {
                [fn.expand("$VIMRUNTIME/lua")] = true,
                [fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
            },
        },
    }
}

-- Create a custom config that enables the snippet support
local function make_config(server)
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.resolveSupport = {
      properties = { "documentation", "detail", "additionalTextEdits" }
    }
    local config = { capabilities = capabilities, on_attach = on_attach }
    if server == "lua" then
        config.settings = lua_settings
    end
    return config
end

-- A function for setting up the language servers
local function setup_servers()
    lspinstall.setup()
    local servers = lspinstall.installed_servers()
    for _, server in ipairs(servers) do
        lspconfig[server].setup(make_config(server))
    end
end

-- Set up the servers
setup_servers()

-- Automatically reload after `:LspInstall <server>`, without restarting Neovim
--
-- It does two things:
--     * Reloads installed servers
--     * Triggers the FileType autocommand that starts the server
lspinstall.post_install_hook = function ()
    setup_servers()
    vim.cmd("bufdo e")
end
