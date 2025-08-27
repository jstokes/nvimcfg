-- Core options
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true

-- Use system clipboard
vim.opt.clipboard = 'unnamedplus'

-- UI tweaks
vim.opt.cmdheight = 1

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

vim.o.exrc = true
vim.o.secure = true

vim.opt.signcolumn = 'auto:2'

-- Diagnostics configuration: keep visible while typing (Option A)
vim.diagnostic.config({
  update_in_insert = true,
  severity_sort = true,
  signs = { priority = 10 },
  virtual_text = {
    spacing = 2,
    prefix = "●",
    source = "if_many",
  },
  underline = true,
  float = { border = "rounded", source = "if_many" },
})
