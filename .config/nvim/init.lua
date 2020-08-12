--
-- Filename: init.vim
-- Author:   David Oniani
-- Modified: August 07, 2020
--
--  _       _ _     _
-- (_)_ __ (_) |_  | |_   _  __ _
-- | | '_ \| | __| | | | | |/ _` |
-- | | | | | | |_ _| | |_| | (_| |
-- |_|_| |_|_|\__(_)_|\__,_|\__,_|
--

-- General Settings {{{

-- Highlighted yank
vim.api.nvim_command('augroup LuaHighlight')
vim.api.nvim_command('  autocmd!')
vim.api.nvim_command('  autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup=\'Search\', timeout=500}')
vim.api.nvim_command('augroup END')

-- }}}

-- colorizer.lua {{{

require 'colorizer'.setup({'*'}, {names = false})

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

  -- Define mappings and corresponding options
  local mappings = {
    ['K'] = '<cmd>lua vim.lsp.buf.hover()<CR>',
    ['gd'] = '<cmd>lua vim.lsp.buf.definition()<CR>',
    ['gr'] = '<cmd>lua vim.lsp.buf.references()<CR>',
    ['ge'] = ':NextDiagnosticCycle<CR>',
    ['gE'] = ':PrevDiagnosticCycle<CR>'
  }

  local opts = {noremap=true, silent=true}

  -- Iterate over mappings and set them up
  for key, val in pairs(mappings) do
    vim.api.nvim_buf_set_keymap(bufnr, 'n', key, val, opts)
  end
end

-- Configure and initialize language servers
local servers = {'ccls', 'pyls', 'rust_analyzer', 'sumneko_lua', 'tsserver'}
for _, lsp in pairs(servers) do
  if lsp == 'sumneko_lua' then
    nvim_lsp[lsp].setup {
      on_attach = custom_attach,
      settings = {
        Lua = {
          diagnostics = {
            globals = {"vim"}
          }
        }
      }
    }
  else
    nvim_lsp[lsp].setup {
      on_attach = custom_attach
    }
  end
end

-- }}}
