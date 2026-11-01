-- Author: David Oniani <onianidavid@gmail.com>
-- Description: Neovim configuration file
-- License: MIT

-- Experimental Lua module loader {{{

vim.loader.enable()

-- }}}

-- Options {{{

-- Indent, no tabs, and spaces
vim.o.breakindent = true
vim.o.expandtab = true
vim.o.shiftround = true
vim.o.shiftwidth = 4
vim.o.smartindent = true
vim.o.softtabstop = 4
vim.o.tabstop = 4

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Splits
vim.o.splitbelow = true
vim.o.splitright = true

-- Folding
vim.o.fillchars = "eob: ,fold: "
vim.o.foldmethod = "marker"

-- Completion
vim.o.completeopt = "menu,menuone,popup,fuzzy"
vim.o.shortmess = vim.o.shortmess .. "c"
vim.o.wildmode = "longest:full,full"

-- Visual
vim.o.colorcolumn = "101"
vim.o.inccommand = "split"
vim.o.laststatus = 3
vim.o.list = true
vim.o.listchars = "tab:▏ ,leadmultispace:▏   ,trail:·,nbsp:␣,extends:»,precedes:«"
vim.o.number = true
vim.o.scrolloff = 4
vim.o.showmode = false
vim.o.signcolumn = "yes"
vim.o.splitkeep = "screen"
vim.o.synmaxcol = 256
vim.o.textwidth = 100

-- Miscellaneous
vim.o.clipboard = "unnamedplus"
vim.o.mouse = "a"
vim.o.swapfile = false
vim.o.updatetime = 256

-- }}}

-- Colors {{{

vim.cmd.colorscheme "default"

local styles = {
    -- Language
    ["Constant"] = { fg = "NvimLightGray2" },
    ["Delimiter"] = { fg = "NvimLightGray2" },
    ["Function"] = { fg = "NvimLightBlue" },
    ["Identifier"] = { fg = "NvimLightGray2" },
    ["Special"] = { fg = "NvimLightGray2" },
    ["Statement"] = { fg = "NvimLightYellow" },
    ["String"] = { fg = "NvimLightGreen" },
    ["Type"] = { fg = "NvimLightGray2" },

    -- Diff
    ["DiffAdd"] = { fg = "Black", bg = "NvimLightGreen" },
    ["DiffChange"] = { fg = "Black", bg = "NvimLightYellow" },
    ["DiffDelete"] = { fg = "Black", bg = "NvimLightRed" },

    -- Comments
    ["@comment.note"] = { fg = "NvimLightBlue", bold = true },
    ["@comment.todo"] = { fg = "NvimLightBlue", bold = true },
    ["@string.documentation.python"] = { fg = "NvimLightGray4", italic = true },
    ["Comment"] = { fg = "NvimLightGray4", italic = true },
    ["Note"] = { fg = "NvimLightBlue", bold = true },
    ["Todo"] = { fg = "NvimLightBlue", bold = true },

    -- Miscellaneous
    ["Changed"] = { fg = "NvimLightBlue" },
    ["DiagnosticHint"] = { fg = "NvimLightGreen" },
    ["DiagnosticInfo"] = { fg = "NvimLightBlue" },
    ["DiffText"] = { bg = "NvimDarkBlue" },
    ["Directory"] = { fg = "NvimLightBlue" },
    ["Folded"] = { fg = "NvimLightGray4" },
    ["MoreMsg"] = { fg = "NvimLightBlue" },
    ["Normal"] = { fg = "NvimLightGray2", bg = "None" },
    ["NormalFloat"] = { fg = "NvimLightGray4", bg = "None" },
    ["Pmenu"] = { bg = "Black", fg = "NvimLightGray2" },
    ["PmenuSel"] = { bg = "NvimLightBlue", fg = "Black" },
    ["Question"] = { fg = "NvimLightBlue" },
    ["QuickFixLine"] = { fg = "NvimLightBlue" },
    ["StatusLine"] = { bg = "NvimDarkGray2", fg = "NvimLightGray2" },
    ["TabLine"] = { bg = "Black", fg = "NvimLightGray2" },
    ["TabLineSel"] = { bg = "NvimLightBlue", fg = "Black" },
    ["WinBar"] = { bg = "None" },
    ["WinSeparator"] = { fg = "NvimDarkGray3" },
    ["Whitespace"] = { fg = "NvimDarkGray2" },

    -- Plugins
    ["BlinkCmpDoc"] = { fg = "NvimLightGray2", bg = "None" },
    ["BlinkCmpDocCursorLine"] = { fg = "Black", bg = "NvimLightBlue" },
    ["FzfLuaBorder"] = { link = "WinSeparator" },
    ["OilDirHidden"] = { fg = "NvimLightBlue" },
    ["OilFileHidden"] = { fg = "None" },
}

for group, style in pairs(styles) do
    vim.api.nvim_set_hl(0, group, style)
end

-- }}}

-- Key Mappings {{{

-- Set the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true, desc = "Map space to no-op" })

-- Leader mappings
vim.keymap.set("n", "<Leader><Leader>", "<C-^>", { desc = "Toggle between buffers" })
vim.keymap.set("n", "<Leader>s", "<Cmd>setl spell! spl=en_us<CR>", { desc = "Toggle spell check" })
vim.keymap.set("n", "<Leader>w", "<Cmd>set wrap!<CR>", { desc = "Toggle line wrapping" })

-- Convenient mappings
vim.keymap.set("n", "N", "Nzz", { desc = "Move to the previous search result and center" })
vim.keymap.set("n", "n", "nzz", { desc = "Move to the next search result and center" })
vim.keymap.set({ "n", "v" }, "Q", "gw", { desc = "Format lines" })

-- Window resizing
vim.keymap.set("n", "<Down>", "<Cmd>resize -4<CR>", { desc = "Shrink vertically" })
vim.keymap.set("n", "<Left>", "<Cmd>vertical resize +4<CR>", { desc = "Shrink horizontally" })
vim.keymap.set("n", "<Right>", "<Cmd>vertical resize -4<CR>", { desc = "Expand horizontally" })
vim.keymap.set("n", "<Up>", "<Cmd>resize +4<CR>", { desc = "Expand vertically" })

-- Vertical navigation
vim.keymap.set({ "n", "v" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = "Down" })
vim.keymap.set({ "n", "v" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = "Up" })

-- Quickfix navigation
vim.keymap.set("n", "<C-j>", "<Cmd>cnext<CR>", { desc = "Jump to next Quickfix item" })
vim.keymap.set("n", "<C-k>", "<Cmd>cprev<CR>", { desc = "Jump to previous Quickfix item" })
vim.keymap.set("n", "<C-q>", function()
    if vim.fn.getqflist({ winid = 0 }).winid ~= 0 then
        vim.cmd.cclose()
    else
        local max_height, min_height, qf_height = 16, 8, #vim.fn.getqflist()
        vim.cmd.copen { count = math.max(min_height, math.min(qf_height, max_height)) }
        vim.cmd.wincmd "p"
    end
end, { desc = "Toggle Quickfix" })

-- Command mode navigation
vim.keymap.set("c", "<C-a>", "<Home>", { desc = "Move cursor to the beginning of line" })
vim.keymap.set("c", "<C-e>", "<End>", { desc = "Move cursor to the end of line" })
vim.keymap.set("c", "<C-h>", "<Left>", { desc = "Move cursor left" })
vim.keymap.set("c", "<C-j>", "<Down>", { desc = "Move cursor down" })
vim.keymap.set("c", "<C-k>", "<Up>", { desc = "Move cursor up" })
vim.keymap.set("c", "<C-l>", "<Right>", { desc = "Move cursor right" })

-- Formatting
vim.api.nvim_create_user_command("F", function()
    local formatprg = vim.bo.formatprg
    if formatprg ~= "" then
        local view = vim.fn.winsaveview()
        vim.cmd [[keepjumps normal! gggqG]]
        vim.fn.winrestview(view)
        vim.notify(string.format("Formatted via 'formatprg': `%s`", formatprg), vim.log.levels.INFO)
    else
        vim.notify(
            string.format(
                "No 'formatprg' set for filetype '%s', skipping formatting",
                vim.bo.filetype
            ),
            vim.log.levels.ERROR
        )
    end
end, { desc = "Format buffer and restore the view" })

-- Undotree
vim.keymap.set("n", "<Leader>u", function()
    vim.cmd.packadd "nvim.undotree"
    require("undotree").open {
        title = "undotree",
        command = "topleft 32vnew",
    }
end, { desc = "Toggle undotree" })

-- }}}

-- Autocommands {{{

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.hl.hl_op()
    end,
})

vim.api.nvim_create_autocmd("VimResized", {
    desc = "Equalize splits when resized",
    group = vim.api.nvim_create_augroup("resize-window", { clear = true }),
    pattern = "*",
    callback = function()
        vim.cmd.wincmd "="
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    desc = "Sets `makeprg` based on filetype",
    group = vim.api.nvim_create_augroup("set-makeprg", { clear = true }),
    pattern = "*",
    callback = function(ev)
        local ft_to_prg = {
            c = "gcc '%' -o '%<' && './%<'",
            cpp = "clang++ -std=c++23 '%' -o '%<' && './%<'",
            go = "go",
            haskell = "runhaskell '%'",
            python = "python3 '%'",
            rust = "cargo",
            sh = "chmod +x '%' && ./'%'",
            tex = "latexmk -interaction=nonstopmode -pdf -outdir=target '%'",
            zsh = "zsh '%'",
        }
        vim.opt_local.makeprg = ft_to_prg[ev.match] or "make"
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    desc = "Sets `formatprg` based on filetype",
    group = vim.api.nvim_create_augroup("set-formatprg", { clear = true }),
    pattern = "*",
    callback = function(ev)
        local ft_to_fmt = {
            css = "prettier --parser css --print-width 100 --stdin-filepath",
            go = "gofmt",
            html = "prettier --parser html --print-width 100 --stdin-filepath",
            javascript = "prettier --parser babel --print-width 100 --stdin-filepath",
            json = "prettier --parser json --print-width 100 --stdin-filepath",
            lua = "stylua --call-parentheses None --column-width 100 --indent-type Spaces --indent-width 4 -",
            markdown = "prettier --parser markdown --print-width 100 --stdin-filepath",
            python = "ruff format --line-length 100 - && isort --profile black -",
            rust = "rustfmt",
            sh = "shfmt -filename %",
            typescript = "prettier --parser typescript --print-width 100 --stdin-filepath",
            zsh = "shfmt -filename %",
        }
        vim.opt_local.formatprg = ft_to_fmt[ev.match] or ""
    end,
})

-- }}}

-- Terminal {{{

vim.api.nvim_create_autocmd("TermOpen", {
    desc = "Custom local settings for terminal buffers",
    group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
    callback = function()
        if vim.bo.filetype == "" then
            vim.bo.filetype = "terminal"
        end
        vim.wo.winfixheight = true
        vim.cmd.startinsert()
    end,
})

vim.keymap.set("n", "T", "<Cmd>12new +term<CR>", { desc = "Open terminal" })
vim.keymap.set("t", "<Esc><Esc>", "<c-\\><c-n>", { desc = "Terminal escape" })

-- }}}

-- Plugins {{{

-- Install packages
vim.pack.add({
    -- Fuzzy search
    { src = "https://github.com/ibhagwan/fzf-lua" },

    -- Asynchronous build and test dispatcher
    { src = "https://github.com/tpope/vim-dispatch" },

    -- File management
    { src = "https://github.com/lewis6991/fileline.nvim" },
    { src = "https://github.com/luukvbaal/nnn.nvim" },
    { src = "https://github.com/stevearc/oil.nvim" },

    -- Git
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/tpope/vim-fugitive" },

    -- LSP
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/saghen/blink.cmp", version = vim.version.range "1.x" },

    -- Nerd Font icons (glyphs)
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
}, { confirm = false })

-- Command for updating all packages
vim.api.nvim_create_user_command("PackUpdate", function()
    vim.pack.update(nil, { force = true })
end, { desc = "Update all plugins" })

-- vim-fugitive {{{

vim.api.nvim_create_autocmd("FileType", {
    desc = "Use Tab key for toggling diff in fugitive.vim",
    group = vim.api.nvim_create_augroup("fugitive-vim-tab-diff", { clear = true }),
    pattern = "fugitive",
    callback = function(ev)
        vim.keymap.set("n", "<Tab>", "=", { buf = ev.buf, remap = true, silent = true })
    end,
})

vim.keymap.set("n", "g<CR>", "<Cmd>Git | only<CR>", { desc = "Show Git status in a new tab" })
vim.keymap.set("n", "g!", ":Git! ", { desc = "Run in background and stream to preview window" })

-- }}}

-- fzf-lua {{{

local fzf = require "fzf-lua"

fzf.setup { keymap = { fzf = { ["ctrl-q"] = "select-all+accept" } } }

vim.keymap.set("n", "<C-g>", fzf.live_grep, { desc = "[Grep]" })
vim.keymap.set("n", "<C-p>", fzf.files, { desc = "[Files]" })

vim.api.nvim_create_user_command("Files", function(opts)
    fzf.files { cwd = opts.args ~= "" and vim.fn.expand(opts.args) or nil }
end, { desc = "[Files]", nargs = "?", complete = "dir" })

vim.api.nvim_create_user_command("Grep", function(opts)
    fzf.live_grep { cwd = opts.args ~= "" and vim.fn.expand(opts.args) or nil }
end, { desc = "[Grep]", nargs = "?", complete = "dir" })

vim.api.nvim_create_user_command("Commits", fzf.git_commits, { desc = "[Commits]" })
vim.api.nvim_create_user_command("Lines", fzf.lines, { desc = "[Lines]" })

vim.keymap.set("n", "gO", fzf.lsp_document_symbols, { desc = "Document Symbols" })
vim.keymap.set("n", "gr/", fzf.lsp_workspace_symbols, { desc = "Workspace Symbols" })

-- }}}

-- gitsigns.nvim {{{

local gitsigns = require "gitsigns"
gitsigns.setup {
    current_line_blame = true,
    signs = {
        add = { text = "+" },
        change = { text = "~" },
    },
}

vim.keymap.set({ "n", "v" }, "<Leader>gr", gitsigns.reset_hunk, { desc = "Reset hunk" })
vim.keymap.set({ "n", "v" }, "<Leader>gs", gitsigns.stage_hunk, { desc = "Stage hunk" })

-- }}}

-- nnn.nvim {{{

vim.api.nvim_create_user_command("NNNReinstall", function()
    local bindir = vim.fs.joinpath(vim.env.HOME, ".local", "bin")
    vim.fs.mkdir(bindir, { parents = true })

    vim.notify("Installing nnn ...", vim.log.levels.INFO)
    local result = vim.fn.system(table.concat({
        "git clone --depth 1 https://github.com/jarun/nnn /tmp/nnn",
        "make -C /tmp/nnn O_NERD=1 O_QSORT=1",
        "mv -f /tmp/nnn/nnn " .. bindir,
        "rm -rf /tmp/nnn",
    }, " && "))

    if vim.v.shell_error ~= 0 then
        vim.notify("Failed to install nnn:\n" .. result, vim.log.levels.ERROR)
        return
    end

    vim.notify("nnn was successfully installed", vim.log.levels.INFO)
end, { desc = "Reinstall nnn" })

require("nnn").setup { explorer = { width = 32 } }

vim.keymap.set({ "n", "t" }, "<C-n>", function()
    vim.cmd.NnnExplorer()
    if vim.bo.filetype == "nnn" then
        vim.cmd.stopinsert()
        vim.cmd.wincmd "p"
    end
end, { desc = "Toggle nnn in a vertical split" })

vim.keymap.set(
    { "n", "t" },
    "<C-b>",
    "<Cmd>NnnPicker<CR>",
    { desc = "Toggle nnn in a floating window" }
)

-- }}}

-- oil.nvim {{{

local oil = require "oil"
oil.setup {
    skip_confirm_for_simple_edits = true,
    view_options = { show_hidden = true },
    win_options = { winbar = "%{v:lua.require('oil').get_current_dir()}" },
}

vim.keymap.set("n", "<Leader>o", function()
    if vim.bo.filetype == "oil" then
        oil.close()
    else
        oil.open()
    end
end, { desc = "Toggle Oil" })

-- }}}

-- LSP {{{

local border = { border = "single" }

vim.diagnostic.config {
    float = border,
    jump = { on_jump = vim.diagnostic.open_float },
    virtual_text = false,
}

vim.lsp.semantic_tokens.enable(false)

vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP configuration on attach",
    group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
    callback = function(event)
        local lsp_keymap_set = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buf = event.buf, desc = "LSP: " .. desc })
        end

        lsp_keymap_set("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
        lsp_keymap_set("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
        lsp_keymap_set("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
        lsp_keymap_set("gr", vim.lsp.buf.references, "[G]oto [R]eferences")

        lsp_keymap_set("dl", vim.diagnostic.setqflist, "[D]iagnostic [L]ist")
        lsp_keymap_set("dn", function()
            vim.diagnostic.jump { count = 1 }
        end, "[D]iagnostic [N]ext")
        lsp_keymap_set("dp", function()
            vim.diagnostic.jump { count = -1 }
        end, "[D]iagnostic [P]revious")
        lsp_keymap_set("ds", vim.diagnostic.open_float, "[D]iagnostic [S]how")

        lsp_keymap_set("ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
        lsp_keymap_set("rn", vim.lsp.buf.rename, "[R]e[N]ame")

        lsp_keymap_set("K", function()
            vim.lsp.buf.hover(border)
        end, "Hover Documentation")

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            lsp_keymap_set("<C-h>", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, "Toggle Inlay [H]ints")
        end
    end,
})

local servers = {
    bashls = {},
    clangd = {
        init_options = {
            fallbackFlags = { "-std=c++23" },
        },
    },
    cmake = {},
    lua_ls = {
        settings = {
            Lua = {
                completion = { callSnippet = "Replace" },
                diagnostics = { globals = { "vim" } },
                format = { enable = false },
                workspace = { checkThirdParty = false },
            },
        },
    },
    ruff = {
        init_options = {
            settings = {
                lint = { args = { "--line-length", "100" } },
            },
        },
    },
    rust_analyzer = {},
    texlab = {},
    ts_ls = {},
    ty = {},
}

require("mason").setup { ui = { border = "single" } }
require("mason-lspconfig").setup { ensure_installed = vim.tbl_keys(servers) }

local blink = require "blink.cmp"
blink.setup {
    completion = {
        documentation = { auto_show = true },
        menu = {
            border = "single",
            winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
        },
    },
    keymap = {
        ["<CR>"] = { "select_and_accept", "fallback" },

        ["<C-j>"] = { "select_next" },
        ["<C-k>"] = { "select_prev" },

        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },

        ["<C-u>"] = { "scroll_documentation_up", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },
    },
}

vim.lsp.config("*", { capabilities = blink.get_lsp_capabilities() })

for server_name, server_config in pairs(servers) do
    vim.lsp.config(server_name, server_config)
end

-- }}}

-- }}}
