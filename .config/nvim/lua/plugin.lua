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

    -- File management
    "nvim-tree/nvim-tree.lua",
    "nvim-tree/nvim-web-devicons",
    "stevearc/oil.nvim",

    -- Git
    "nvim-lua/plenary.nvim",
    "NeogitOrg/neogit",
    "lewis6991/gitsigns.nvim",
    "sindrets/diffview.nvim",

    -- Syntax highlighting and code navigation
    "nvim-treesitter/nvim-treesitter",

    -- LSP
    "j-hui/fidget.nvim",
    "neovim/nvim-lspconfig",
    "williamboman/mason-lspconfig.nvim",
    "williamboman/mason.nvim",

    -- LSP: Autocompletion
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-path",
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

-- Fuzzy search {{{

local fzf = require "fzf-lua"
vim.keymap.set("n", "<Leader>d", fzf.diagnostics_document, { desc = "LSP: Document [D]iagnostics" })
vim.keymap.set("n", "<Leader>f", fzf.files, { desc = "Find [F]iles" })
vim.keymap.set("n", "<Leader>l", fzf.lines, { desc = "Open [L]ines" })
vim.keymap.set("n", "<Leader>r", fzf.live_grep, { desc = "Search Terms via [R]g" })
vim.g.fzf_action = { ["ctrl-s"] = "split", ["ctrl-v"] = "vsplit" }

-- }}}

-- File management {{{

require "nvim-tree".setup {}
vim.api.nvim_set_hl(0, "NvimTreeExecFile", { fg = "NvimLightGreen" })
vim.api.nvim_set_hl(0, "NvimTreeFolderIcon", { fg = "NvimLightBlue" })
vim.api.nvim_set_hl(0, "NvimTreeRootFolder", { fg = "NvimLightBlue" })
vim.keymap.set("n", "<C-n>", function() require "nvim-tree.api".tree.toggle({ focus = false }) end)

require("oil").setup { view_options = { show_hidden = true } }
vim.api.nvim_set_hl(0, "OilDir", { fg = "NvimLightBlue" })
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- }}}

-- Git {{{

local neogit = require "neogit"
neogit.setup { integrations = { diffview = true, fzf_lua = true } }
vim.api.nvim_create_user_command("G", neogit.open, { desc = "Open Neo[G]it" })

local gitsigns = require "gitsigns"
gitsigns.setup {
    current_line_blame = true,
    signs = {
        add = { text = "+" },
        change = { text = "~" },
        changedelete = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
    },
}

-- }}}

-- Syntax highlighting and code navigation {{{

require("nvim-treesitter.configs").setup {
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
        "typescript",
        "vim",
        "vimdoc",
    },
    highlight = { enable = true, additional_vim_regex_highlighting = false },
    indent = { enable = true },
}
require("nvim-treesitter.install").prefer_git = true

-- }}}

-- LSP {{{

local on_attach = function(client, bufnr)
    local m = function(keys, func, desc)
        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
    end

    m("F", vim.lsp.buf.signature_help, "[F]unction Signature")
    m("H", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, "[H]ints")
    m("T", vim.lsp.buf.signature_help, "[T]ype Definition")
    m("ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
    m("dl", vim.diagnostic.setloclist, "[D]iagnostic [L]ist")
    m("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
    m("rn", vim.lsp.buf.rename, "[R]e[n]ame")

    vim.api.nvim_buf_create_user_command(bufnr, "F", function()
        if vim.lsp.buf.format then
            vim.lsp.buf.format()
        elseif vim.lsp.buf.formatting then
            vim.lsp.buf.formatting()
        end
    end, { desc = "[F]ormat Current Buffer" })

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
                format = {
                    enable = true,
                    defaultConfig = {
                        indent_size = "4",
                        indent_style = "space",
                        max_line_length = "100",
                    },
                },
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
    tsserver = {},
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

-- LSP: Autocompletion {{{

require("lspkind").init {}

local cmp = require "cmp"

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
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
    },
    mapping = cmp.mapping.preset.insert {
        ["<C-j>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
        ["<C-k>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
        ["<TAB>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
        ["<S-TAB>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
        ["<CR>"] = cmp.mapping.confirm { select = true },
        ["<C-c>"] = cmp.mapping.close(),
        ["<C-y>"] = cmp.mapping(
            cmp.mapping.confirm {
                behavior = cmp.ConfirmBehavior.Insert,
                select = true,
            },
            { "i", "c" }
        ),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-u>"] = cmp.mapping.scroll_docs(4),
    },
    snippet = {
        expand = function(args)
            vim.snippet.expand(args.body)
        end,
    },
    window = {
        completion = { border = border, scrollbar = "║" },
        documentation = { border = border, scrollbar = "║" },
    },
}

cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = { { name = "buffer" } },
})

cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
})

-- }}}

-- }}}
