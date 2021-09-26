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
		lua = { { formatCommand = "stylua -", formatStdin = true } },
		markdown = { { formatCommand = "prettier --stdin-filepath ${INPUT}", formatStdin = true } },
		python = { { formatCommand = "black -l 100 -", formatStdin = true } },
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
local function make_config(server)
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	capabilities.textDocument.completion.completionItem.resolveSupport = {
		properties = { "documentation", "detail", "additionalTextEdits" },
	}
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

-- Access LSP configurations
local lspconfig = require("lspconfig")

-- Set up the servers
local servers = { "bashls", "clangd", "cmake", "efm", "gopls", "pyright", "rust_analyzer" }
for _, server in ipairs(servers) do
	lspconfig[server].setup(make_config(server))
end
