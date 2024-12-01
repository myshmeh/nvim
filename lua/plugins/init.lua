--------------------------------------------------------------------------
-- mini.nvim setup
-- https://github.com/echasnovski/mini.nvim
--------------------------------------------------------------------------
-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = {
    'git', 'clone', '--filter=blob:none',
    'https://github.com/echasnovski/mini.nvim', mini_path
  }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- Set up 'mini.deps' (customize to your liking)
require('mini.deps').setup({ path = { package = path_package } })

-- Use 'mini.deps'. `now()` and `later()` are helpers for a safe two-stage
-- startup and are optional.
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

add({
  source = 'junegunn/vim-peekaboo',
})

now(function()
  local mini_palette = require('mini.base16').mini_palette(
  '#181810', -- background
  '#ebf5cf', -- foreground
  55         -- accent chroma
  )
  require('mini.base16').setup({
    palette = mini_palette,
    use_cterm = true,
  })
end)

now(function()
  require('mini.notify').setup()
  vim.notify = require('mini.notify').make_notify()
end)

now(function()
  require('mini.icons').setup({
    style = 'ascii',
  })
end)

now(function()
  require('mini.files').setup()
end)

now(function()
  require('mini.tabline').setup({
    show_icons = false,
    format = function(buf_id, label)
      return '(' .. buf_id .. ')' ..MiniTabline.default_format(buf_id, label)
    end
  })
end)

now(function()
  require('mini.fuzzy').setup()
end)

now(function()
  require('mini.pick').setup()
end)
