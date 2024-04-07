-- Neovim configuration file
-- by David Oniani <onianidavid@gmail.com>
-- MIT License

local is_bootstrap = false
local path = vim.fn.stdpath "data" .. "/site/pack/paqs/start/paq-nvim"
local repo = "https://github.com/savq/paq-nvim.git"
if not vim.loop.fs_stat(path) then
    is_bootstrap = true
    vim.fn.system { "git", "clone", "--depth=1", repo, path }
    vim.cmd "packadd paq-nvim"
end

local packages = {
    -- Let Paq manage itself
    "savq/paq-nvim",

    -- Fuzzy search
    "ibhagwan/fzf-lua",

    -- File explorer
    "nvim-tree/nvim-tree.lua",
    "nvim-tree/nvim-web-devicons",

    -- Syntax highlighting and code navigation
    "nvim-treesitter/nvim-treesitter",

    -- LSP
    "j-hui/fidget.nvim",
    "neovim/nvim-lspconfig",
    "williamboman/mason-lspconfig.nvim",
    "williamboman/mason.nvim",

    -- Autocompletion
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-path",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "onsails/lspkind-nvim",
}

local paq = require "paq"
paq(packages)

if is_bootstrap then
    paq.install()
    print "================================"
    print "  Plugins are being installed"
    print "    Wait till Paq completes,"
    print "      then restart nvim"
    print "================================"
    return
end

local fzf = require "fzf-lua"
vim.keymap.set("n", "<Leader>f", fzf.files)
vim.keymap.set("n", "<Leader>l", fzf.lines)
vim.keymap.set("n", "<Leader>r", fzf.live_grep)
vim.g.fzf_action = { ["ctrl-s"] = "split", ["ctrl-v"] = "vsplit" }

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup {}
vim.keymap.set("n", "<C-n>", "<Cmd>NvimTreeToggle<CR>")
vim.api.nvim_set_hl(0, "NvimTreeExecFile", { fg = "NvimLightGreen" })
vim.api.nvim_set_hl(0, "NvimTreeRootFolder", { fg = "None" })

require("nvim-treesitter.configs").setup {
    highlight = { enable = true, additional_vim_regex_highlighting = false },
    indent = { enable = true },
}

local on_attach = function(client, bufnr)
    local lsp_keymap_set = function(keys, func, desc)
        if desc then
            desc = "LSP: " .. desc
        end
        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end

    lsp_keymap_set("K", vim.lsp.buf.hover, "Hover Documentation")
    lsp_keymap_set("T", vim.lsp.buf.signature_help, "Signature Documentation")
    lsp_keymap_set("ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
    lsp_keymap_set("dl", vim.diagnostic.setloclist, "[D]iagnostic [L]ist")
    lsp_keymap_set("dn", vim.diagnostic.goto_next, "[D]iagnostic [N]ext")
    lsp_keymap_set("dp", vim.diagnostic.goto_prev, "[D]iagnostic [P]revious")
    lsp_keymap_set("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
    lsp_keymap_set("rn", vim.lsp.buf.rename, "[R]e[n]ame")

    vim.api.nvim_buf_create_user_command(bufnr, "F", function()
        if vim.lsp.buf.format then
            vim.lsp.buf.format()
        elseif vim.lsp.buf.formatting then
            vim.lsp.buf.formatting()
        end
    end, { desc = "LSP: [F]ormat Current Buffer" })

    vim.diagnostic.config {
        float = { border = "single" },
        virtual_text = false,
    }

    vim.lsp.handlers["textDocument/hover"] =
        vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })

    vim.lsp.handlers["textDocument/signatureHelp"] =
        vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" })

    if client.name == "ruff_lsp" then
        client.server_capabilities.hoverProvider = false
    end
end

local servers = {
    bashls = {},
    clangd = {},
    cmake = {},
    lua_ls = {
        settings = {
            Lua = {
                completion = { callSnippet = "Replace" },
                diagnostics = { globals = { "vim" } },
                telemetry = { enable = false },
                workspace = { checkThirdParty = false },
            },
        },
    },
    pyright = {
        settings = {
            pyright = { disableOrganizeImports = true },
            python = { analysis = { ignore = { "*" } } },
        },
    },
    ruff_lsp = {
        init_options = {
            settings = {
                format = { args = { "--line-length", "100" } },
                lint = { args = { "--line-length", "100" } },
            },
        },
    },
    rust_analyzer = {},
    texlab = {},
}

require("fidget").setup {}
require("lspconfig.ui.windows").default_options.border = "single"
require("mason").setup { ui = { border = "single" } }

local lspconfig = require "lspconfig"
local mason_lspconfig = require "mason-lspconfig"

local cmp_capabilities = require "cmp_nvim_lsp"
local default_capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = cmp_capabilities.default_capabilities(default_capabilities)

mason_lspconfig.setup { ensure_installed = vim.tbl_keys(servers) }
mason_lspconfig.setup_handlers {
    function(server_name)
        lspconfig[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name].settings or {},
            init_options = {
                documentFormatting = true,
                settings = (servers[server_name].init_options or {}).settings or {},
            },
        }
    end,
}

local cmp = require "cmp"
local lspkind = require "lspkind"
local luasnip = require "luasnip"

local border = {
    { "╭", "FoldColumn" },
    { "─", "FoldColumn" },
    { "╮", "FoldColumn" },
    { "│", "FoldColumn" },
    { "╯", "FoldColumn" },
    { "─", "FoldColumn" },
    { "╰", "FoldColumn" },
    { "│", "FoldColumn" },
}

cmp.setup {
    experimental = { ghost_text = true },
    formatting = {
        format = lspkind.cmp_format {
            menu = {
                nvim_lsp = "LSP",
                luasnip = "LuaSnip",
                buffer = "Buffer",
                path = "Path",
                latex_symbols = "LaTeX",
            },
        },
    },
    mapping = cmp.mapping.preset.insert {
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-u>"] = cmp.mapping.scroll_docs(4),
        ["<C-o>"] = cmp.mapping.complete(),
        ["<C-c>"] = cmp.mapping.close(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
    },
    window = {
        completion = {
            border = border,
            scrollbar = "║",
        },
        documentation = {
            border = border,
            scrollbar = "║",
        },
    },
}

cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" },
    },
})

cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        { name = "cmdline" },
    }),
})
