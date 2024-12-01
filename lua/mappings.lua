local kmset = vim.keymap.set

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- mini.files
local minifiles_toggle = function(...)
  if not MiniFiles.close() then MiniFiles.open(...) end
end
kmset('n', '<leader>mf', minifiles_toggle)
kmset('n', '<leader>ms', MiniFiles.synchronize)
-- set pre-defined marks
local set_mark = function(id, path, desc)
  MiniFiles.set_bookmark(id, path, { desc = desc })
end
vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesExplorerOpen',
  callback = function()
    set_mark('c', vim.fn.stdpath('config'), 'Config') -- path
    set_mark('w', vim.fn.getcwd, 'Working directory') -- callable
    set_mark('~', '~', 'Home directory')
  end,
})

-- mini.deps
kmset('n', '<leader>mdu', '<cmd>DepsUpdate<cr>')
kmset('n', '<leader>mdc', '<cmd>DepsClean<cr>')

-- turn highlight off
kmset('n', '<leader>nh', '<cmd>nohlsearch<cr>')

-- change current working directory locally and print curr work dir after that,
-- see https://vim.fandom.com/wiki/Set_working_directory_to_the_current_file
kmset('n', '<leader>cd', '<cmd>lcd %:p:h<cr><cmd>pwd<cr>', { desc = 'change curr work dir' })

-- split
kmset('n', '<leader>sh', '<cmd>split<cr>')
kmset('n', '<leader>sv', '<cmd>vsplit<cr>')

-- terminal
-- open a new tab, then open a terminal
kmset('n', '<leader>tm', '<cmd>tabnew<cr><cmd>terminal<cr>')
-- use Esc to quit builtin terminal
kmset('t', '<Esc>', [[<c-\><c-n>]])

-- buffer
kmset('n', '<leader>bu', function()
  local id = vim.fn.input('[EDIT BUFFER] id: ')
  vim.cmd('buffer ' .. id)
end)
kmset('n', '<leader>bd', function()
  local id = vim.fn.input('[DEL BUFFER] id: ')
  vim.cmd('bdelete ' .. id)
end)
