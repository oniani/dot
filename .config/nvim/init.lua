--
-- Filename: init.vim
-- Author:   David Oniani
-- Modified: July 18, 2020
--
--  _       _ _     _
-- (_)_ __ (_) |_  | |_   _  __ _
-- | | '_ \| | __| | | | | |/ _` |
-- | | | | | | |_ _| | |_| | (_| |
-- |_|_| |_|_|\__(_)_|\__,_|\__,_|
--

-- Basics {{{

-- Highlighted yank
vim.api.nvim_command('augroup LuaHighlight')
vim.api.nvim_command('  autocmd!')
vim.api.nvim_command('  autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup=\'Substitute\', timeout=500}')
vim.api.nvim_command('augroup END')

-- }}}

-- LSP (Language Server Protocol) {{{

-- 'nvim_lsp' is a requirement!
local nvim_lsp = require'nvim_lsp'

-- Define what happens on attaching a language server
local custom_attach = function(client, bufnr)
  require'completion'.on_attach()
  require'diagnostic'.on_attach()

  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  vim.api.nvim_command('autocmd CursorHold <buffer> lua vim.lsp.util.show_line_diagnostics()')
  vim.api.nvim_command('set signcolumn=yes')

  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_command('autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()')
  end

  local opts = {noremap=true, silent=true}
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K',  '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'ge', ':NextDiagnosticCycle<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gE', ':PrevDiagnosticCycle<CR>', opts)
end

-- Configure and initialize language servers
local servers = {'sumneko_lua', 'pyls', 'rust_analyzer', 'tsserver'}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = custom_attach;
  }
end

-- }}}
