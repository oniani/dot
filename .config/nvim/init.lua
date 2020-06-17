--
-- Filename: init.vim
-- Author:   David Oniani
-- Modified: June 17, 2020
--
--  _       _ _     _             
-- (_)_ __ (_) |_  | |_   _  __ _ 
-- | | '_ \| | __| | | | | |/ _` |
-- | | | | | | |_ _| | |_| | (_| |
-- |_|_| |_|_|\__(_)_|\__,_|\__,_|
--

-- 'nvim_lsp' is a requirement!
local nvim_lsp = require'nvim_lsp'

-- Define what happens on attaching a language server
local custom_attach = function(_, bufnr)
  require'completion'.on_attach()
  require'diagnostic'.on_attach()

  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  vim.api.nvim_command('autocmd CursorHold <buffer> lua vim.lsp.util.show_line_diagnostics()')
  vim.api.nvim_command('autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()')

  local opts = {noremap=true, silent=true}
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'ge', ':NextDiagnosticCycle<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gE', ':PrevDiagnosticCycle<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K',  '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
end

-- Configure and initialize language servers
local_servers = {'pyls', 'rls'}
for _, lsp in ipairs(local_servers) do
  nvim_lsp[lsp].setup {
    on_attach = custom_attach;
  }
end
