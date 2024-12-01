local options = {
  fileencoding = "utf-8",
  autoread = true,
  wrap = true,
  hlsearch = true, -- Set highlight on search
  incsearch = true,
  showmode = true,
  expandtab = true,
  shiftwidth = 2,
  tabstop = 2,
  softtabstop = 2,
  autoindent = true,
  smartindent = true,
  ignorecase = true, -- Case insensitive searching UNLESS /C or capital in search
  number = true, -- Make line numbers default
  relativenumber = true,
  clipboard = "unnamed,unnamedplus", -- Use system clipboard
  cursorline = true,
  mouse = "a", -- Enable mouse mode
  completeopt = "menuone", -- Set completeopt to have a better completion experience
}

for key, value in pairs(options) do
  vim.opt[key] = value
end

local indents = { python = 4, rust = 2, c = 2, make = 4, lua = 2, java = 2, json = 4, sql = 2 }
for filetype, size in pairs(indents) do
  vim.api.nvim_create_autocmd("FileType", {
    pattern = filetype,
    callback = function()
      vim.opt.shiftwidth = size
      vim.opt.tabstop = size
      vim.opt.softtabstop = size
    end,
  })
end
