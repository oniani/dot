-- Language Server Client (LSP) settings
-- Access Nvim API and functions
local api = vim.api
local fn = vim.fn

-- Access LSP install and LSP configurations
local lspinstall = require("lspinstall")
local lspconfig = require("lspconfig")

-- Set these options on language server attachment
local on_attach = function(client, bufnr)
    -- Convenient function for setting keymaps
    local function keymap(...) api.nvim_buf_set_keymap(bufnr, ...) end

    -- Mapping options
    local opts = {noremap = true, silent = true}

    -- Mappings
    keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
    keymap("n", "Ld", "<Cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
    keymap("n", "Lr", "<Cmd>lua vim.lsp.buf.references()<CR>", opts)
    keymap("n", "T", "<Cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
    keymap("n", "nD", "<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
    keymap("n", "nd", "<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
    keymap("n", "nr", "<Cmd>lua vim.lsp.buf.rename()<CR>", opts)

    -- If a language server has document formatting capabilities, format on save
    if client.resolved_capabilities.document_formatting then
        api.nvim_exec([[
            augroup Format
                autocmd!
                autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting_sync()
            augroup END
        ]], false)
    end
end

-- Configure efm language server
local efm_settings = {
    rootMarkers = {".git/"},
    languages = {
        go = {{formatCommand = "gofmt -s", formatStdin = true}},
        lua = {
            {
                formatCommand = "lua-format --column-limit=79",
                formatStdin = true
            }
        },
        markdown = {
            {
                formatCommand = "prettier --stdin-filepath ${INPUT}",
                formatStdin = true
            }
        },
        python = {{formatCommand = "black -l 79 -", formatStdin = true}}
    }
}

-- Configure sumneko_lua language server
local sumneko_lua_settings = {
    Lua = {
        runtime = {
            -- LuaJIT in the case of Neovim
            version = "LuaJIT",
            -- Set up the Lua path
            path = vim.split(package.path, ";")
        },
        diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = {"vim"}
        },
        workspace = {
            -- Make the server aware of Neovim runtime files
            library = {
                [fn.expand("$VIMRUNTIME/lua")] = true,
                [fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
            }
        }
    }
}

-- Configure rust_analyzer language server
local rust_analyzer_settings = {
    ["rust-analyzer"] = {
        checkOnSave = {
            allFeatures = true,
            overrideCommand = {
                "cargo", "clippy", "--all-features", "--all-targets",
                "--message-format=json", "--workspace"
            }
        }
    }
}

-- Makes a custom config with the snippet support
local function make_config(server)
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = {"documentation", "detail", "additionalTextEdits"}
    }
    local config = {capabilities = capabilities, on_attach = on_attach}
    if server == "efm" then
        config.filetypes = fn.keys(efm_settings.languages)
        config.init_options = {documentFormatting = true}
        config.settings = efm_settings
    elseif server == "lua" then
        config.settings = sumneko_lua_settings
    elseif server == "rust" then
        config.settings = rust_analyzer_settings
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
lspinstall.post_install_hook = function()
    setup_servers()
    api.nvim_command("bufdo e")
end
