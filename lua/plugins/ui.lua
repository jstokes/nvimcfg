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
    end,
  },

  -- which-key
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    -- no-neck-pain: registered in a separate spec, but add which-key group label early
    {
      'shortcuts/no-neck-pain.nvim',
      keys = { '<leader>z' },
      opts = false,
      init = function()
        local ok_wk, which_key = pcall(require, 'which-key')
        if ok_wk then
          which_key.add { { '<leader>z', group = 'Zen / NoNeckPain' } }
        end
      end,
    },

    opts = {
      plugins = { spelling = true },
      win = { border = 'single' },
      -- Silence noisy overlap warnings for common plugin prefixes
      diagnostics = {
        -- only show important issues
        show_overlaps = false,
        show_duplicates = true,
        show_mappings = true,
      },
      -- Ignore some prefixes for overlap checks (Comment.nvim, nvim-surround)
      -- Supported in recent which-key versions via exclude patterns
      notify = true,
    },
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
