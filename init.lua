-- init.lua split using lazy.nvim structure
-- Leader must be set before lazy
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Disable language providers we don't use to silence health warnings
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- Load core options early
require 'config.options'
require 'config.autocmds'

-- Plugin specs are split by domain under lua/plugins/*.lua
require('lazy').setup {
  spec = {
    { import = 'plugins.ui' },
    { import = 'plugins.treesitter' },
    { import = 'plugins.paredit' },
    { import = 'plugins.fzf' },
    { import = 'plugins.git' },
    { import = 'plugins.editing' },
    { import = 'plugins.cmp' },
    { import = 'plugins.conform' },
    { import = 'plugins.clojure' },
    { import = 'plugins.lint' },
    { import = 'plugins.lsp' },
    { import = 'plugins.trouble' },
    { import = 'plugins.neotest' },
    { import = 'plugins.claudecode' },
    { import = 'plugins.copilot' },
    { import = 'plugins.minuet' },
    { import = 'plugins.multiplexer' },
    { import = 'plugins.markdown' },
    -- Machine-local plugins (gitignored)
    vim.uv.fs_stat(vim.fn.stdpath 'config' .. '/lua/plugins/amperity.lua') and { import = 'plugins.amperity' } or {},
  },
  checker = { enabled = false },
  rocks = { enabled = false },
}

-- After plugins are set up, load keymaps
require 'config.keymaps'
