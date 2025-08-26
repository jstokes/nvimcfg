return {
  -- Icons (keep devicons; drop mini.icons for simplicity)
  { 'nvim-tree/nvim-web-devicons', lazy = true },

  -- Colorscheme: load here so it's applied early
  { 'EdenEast/nightfox.nvim', priority = 1000, config = function() vim.cmd('colorscheme nightfox') end },

  -- which-key
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      plugins = { spelling = true },
      win = { border = 'single' },
    },
  },

  -- Statusline with buffers (tabline shows buffers)
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = { theme = 'auto', section_separators = '', component_separators = '' },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
      tabline = {
        lualine_a = { { 'buffers', mode = 4, symbols = { alternate_file = '' } } },
        lualine_z = { 'tabs' },
      },
      extensions = { 'fugitive', 'quickfix', 'man' },
    },
  },

  -- Session persistence
  {
    'folke/persistence.nvim',
    event = 'BufReadPre',
    opts = { options = { 'buffers', 'curdir', 'tabpages', 'winsize' } },
  },
}
