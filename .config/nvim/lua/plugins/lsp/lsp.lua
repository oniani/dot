-- Language Server Client (LSP) settings

-- Access LSP configurations
local nvim_lsp = require("lspconfig")

-- Access Nvim API and functions
local api = vim.api
local fn  = vim.fn

-- Set these options on language server attachment
local custom_attach = function(client, bufnr)
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
local lua_attach = {
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

-- All language servers
local servers = { "gopls", "sumneko_lua", "pyright", "rust_analyzer" }

-- Loop over all language servers and set them up
for _, server in ipairs(servers) do
    nvim_lsp[server].setup {
	on_attach = custom_attach
    }
end
