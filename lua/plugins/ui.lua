-- stylua: ignore

return {
-- ui.lua

  -- Icons (keep devicons; drop mini.icons for simplicity)
  { 'nvim-tree/nvim-web-devicons', lazy = true },

  -- Colorscheme: load here so it's applied early
  {
    'EdenEast/nightfox.nvim',
    priority = 1000,
    config = function()
      vim.cmd 'colorscheme carbonfox'
      -- Make split borders more apparent
      -- Use a thicker vertical split character and an accent color for the separator
      pcall(function()
        vim.opt.fillchars:append({ vert = '┃' })
      end)
      -- Use FloatBorder colors for window separators for better visibility
      pcall(vim.api.nvim_set_hl, 0, 'WinSeparator', { link = 'FloatBorder' })
      pcall(vim.api.nvim_set_hl, 0, 'VertSplit', { link = 'FloatBorder' })
      -- Ensure diff colors are visible in Neogit
      -- Keep background highlights for additions/deletions/context, including header lines
      pcall(vim.api.nvim_set_hl, 0, 'NeogitDiffAdd',              { bg = '#2b3b2b', fg = '#8ccf7e' })
      pcall(vim.api.nvim_set_hl, 0, 'NeogitDiffAddHighlight',     { bg = '#2f4731', fg = '#a6d189', bold = true })
      pcall(vim.api.nvim_set_hl, 0, 'NeogitDiffAddCursor',        { bg = '#2f4731', fg = '#a6d189', bold = true })
      pcall(vim.api.nvim_set_hl, 0, 'NeogitDiffDelete',           { bg = '#3b2b2b', fg = '#f38ba8' })
      pcall(vim.api.nvim_set_hl, 0, 'NeogitDiffDeleteHighlight',  { bg = '#473131', fg = '#f5a0b4', bold = true })
      pcall(vim.api.nvim_set_hl, 0, 'NeogitDiffDeleteCursor',     { bg = '#473131', fg = '#f5a0b4', bold = true })
      pcall(vim.api.nvim_set_hl, 0, 'NeogitDiffContext',          { bg = '#2c2e34' })
      pcall(vim.api.nvim_set_hl, 0, 'NeogitDiffContextHighlight', { bg = '#333642' })
      pcall(vim.api.nvim_set_hl, 0, 'NeogitDiffContextCursor',    { bg = '#333642' })
      pcall(vim.api.nvim_set_hl, 0, 'NeogitDiffHeader',           { bg = '#2c2e34', fg = '#86aaec', bold = true })
      pcall(vim.api.nvim_set_hl, 0, 'NeogitDiffHeaderHighlight',  { bg = '#333642', fg = '#e5c890', bold = true })
      pcall(vim.api.nvim_set_hl, 0, 'NeogitCursorLine',           { bg = 'NONE', fg = 'NONE' })
      -- Also set core Diff groups so generic diffs show backgrounds
      pcall(vim.api.nvim_set_hl, 0, 'DiffAdd',    { bg = '#26382c' })
      pcall(vim.api.nvim_set_hl, 0, 'DiffDelete', { bg = '#3a262b' })
      pcall(vim.api.nvim_set_hl, 0, 'DiffChange', { bg = '#3a3526' })
    end,
  },

  -- which-key
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      plugins = { spelling = true },
      win = { border = 'single' },
      notify = true,
    },
  },

  -- no-neck-pain (zen mode)
  {
    'shortcuts/no-neck-pain.nvim',
    keys = { { '<leader>z', '<cmd>NoNeckPain<cr>', desc = 'Zen / NoNeckPain' } },
    opts = {},
  },

  -- Statusline (no buffer tabline here; bufferline.nvim will handle tabs)
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = { theme = 'auto', section_separators = '', component_separators = '' },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = {
          'branch',
          { 'diff', symbols = { added = '', modified = '', removed = '' } },
          { 'diagnostics', symbols = { error = '', warn = '', info = '', hint = '' } },
        },
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
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

  -- Bufferline for better buffer navigation
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        diagnostics = 'nvim_lsp',
        show_buffer_close_icons = true,
        show_close_icon = false,
        separator_style = 'thin',
        always_show_bufferline = true,
        diagnostics_indicator = function(_, _, diag)
          local parts = {}
          if diag.error then table.insert(parts, ' ' .. diag.error) end
          if diag.warning then table.insert(parts, ' ' .. diag.warning) end
          return table.concat(parts, ' ')
        end,
        show_buffer_icons = true,
        indicator = { style = 'icon', icon = '▎' },
        modified_icon = '●',
        buffer_close_icon = '✕',
      },
    },
  },
}
