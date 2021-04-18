-- Language Server Client (LSP) settings

-- Get the LSP install and LSP configurations
local lspinstall = require("lspinstall")
local nvim_lsp = require("lspconfig")

-- Access Nvim API and functions
local api = vim.api
local fn  = vim.fn

-- Set these options on language server attachment
local on_attach = function(client, bufnr)
    -- Convenient functions for setting keymaps and options
    local function buf_set_keymap(...) api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) api.nvim_buf_set_option(bufnr, ...) end

    -- Enable omni completion
    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mapping options
    local opts = { noremap = true, silent = true }

    -- Mappings
    buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    buf_set_keymap("n", "Ld", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
    buf_set_keymap("n", "Lr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    buf_set_keymap("n", "T", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    buf_set_keymap("n", "nD", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
    buf_set_keymap("n", "nd", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
    buf_set_keymap("n", "nr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)

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
            path = vim.split(package.path, ";"),
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

-- Config that activates keymaps and enables snippet support
local function make_config()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    return {
        -- Enable snippet support
        capabilities = capabilities,
        -- Map buffer-local keybindings when the language server attaches
        on_attach = on_attach
    }
end

-- A function for setting language servers
local function setup_servers()
    -- Make sure the plugin is set up
    lspinstall.setup()

    -- Get all servers to be automatically installed
    local required_servers = { "go", "lua", "python", "rust" }

    -- Get all installed servers
    local installed_servers = lspinstall.installed_servers()

    -- Set up defined servers and map buffer-local keybindings on attachment
    for _, server in pairs(required_servers) do
        -- Install a language server if it is not already installed
        if not vim.tbl_contains(installed_servers, server) then
            lspinstall.install_server(server)
        end

        -- Get the config
        local config = make_config()

        -- Language specific config
        if server == "lua" then
            config.settings = lua_settings
        end

        -- Set up the language server
        nvim_lsp[server].setup(config)
    end
end

-- Set up language servers
setup_servers()

-- Automatically reload after `:LspInstall <server>`, without restarting Neovim
require("lspinstall").post_install_hook = function()
    -- Reload installed servers
    setup_servers()
    -- This triggers the FileType autocmd that starts the server
    vim.cmd("bufdo e")
end
