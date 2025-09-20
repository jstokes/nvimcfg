-- Core options
vim.opt.number = false
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

vim.opt.signcolumn = 'no'

-- Diagnostics configuration: minimal clutter
vim.diagnostic.config({
  update_in_insert = false,
  severity_sort = true,
  signs = false, -- no gutter signs
  virtual_text = {
    spacing = 0,
    -- icon-only inline diagnostics (no text), WARN/ERROR only
    prefix = function(d)
      local s = vim.diagnostic.severity
      local icons = {
        [s.ERROR] = "",
        [s.WARN]  = "",
        [s.INFO]  = "",
        [s.HINT]  = "",
      }
      return (icons[d.severity] or "●") .. " "
    end,
    format = function() return "" end,
    severity = { min = vim.diagnostic.severity.WARN },
    source = "if_many",
  },
  underline = { severity = { min = vim.diagnostic.severity.WARN } },
  float = { border = "rounded", source = "if_many" },
})
