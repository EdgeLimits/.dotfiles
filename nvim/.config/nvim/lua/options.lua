-- 
-- Set listchars
vim.o.listchars = 'nbsp:␣,eol:↲,tab:»\\ ,extends:›,precedes:‹,trail:•'
vim.opt.spelllang = 'en_us'
vim.opt.spell = true
vim.opt.clipboard = 'unnamedplus'
-- Set showbreak
vim.o.showbreak = '↳ '

vim.opt.swapfile = false

-- Disable number column in visual mode
vim.api.nvim_exec([[
  augroup my_visuallistchars
    autocmd!
    autocmd CursorMoved * if mode() =~# "[vV\<C-v>]" | set list | else | set nolist | endif
  augroup END
]], false)

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
