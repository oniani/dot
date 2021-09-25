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
    TypeParameter = ' Type-param',
    Unit = ' Unit',
    Value = " Value",
    Var = " Var"
}

-- Access cmp configurations
local cmp = require("cmp")

-- Set up cmp
cmp.setup {
    snippet = {expand = function(args) require("luasnip").lsp_expand(args.body) end},
    mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm {behavior = cmp.ConfirmBehavior.Replace, select = true},
        ["<Tab>"] = function(fallback)
            if vim.fn.pumvisible() == 1 then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-n>", true, true, true), "n")
            else
                fallback()
            end
        end,
        ["<S-Tab>"] = function(fallback)
            if vim.fn.pumvisible() == 1 then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-p>", true, true, true), "n")
            else
                fallback()
            end
        end
    },
    sources = {{name = "buffer"}, {name = "nvim_lsp"}, {name = "path"}},
    formatting = {
        format = function(_, vim_item)
            vim_item.kind = kinds[vim_item.kind]
            return vim_item
        end
    }
}
