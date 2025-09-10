return {
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      sign_priority = 5,
      signcolumn = false, -- do not use the signcolumn at all
      numhl = true,       -- subtle: highlight only the line number for changes
      linehl = false,
      word_diff = false,
      signs = {
        add          = { text = '' },
        change       = { text = '' },
        delete       = { text = '' },
        topdelete    = { text = '' },
        changedelete = { text = '' },
        untracked    = { text = '' },
      },
      -- You can further reduce noise by linking numhl to LineNr in your colorscheme setup
    },
    config = function(_, opts)
      require('gitsigns').setup(opts)
      -- Optional: make number highlights as subtle as regular line numbers
      vim.api.nvim_set_hl(0, 'GitSignsAddNr',    { link = 'LineNr' })
      vim.api.nvim_set_hl(0, 'GitSignsChangeNr', { link = 'LineNr' })
      vim.api.nvim_set_hl(0, 'GitSignsDeleteNr', { link = 'LineNr' })
    end,
  },
  { 'ruifm/gitlinker.nvim', dependencies = { 'nvim-lua/plenary.nvim' }, opts = {} },
  { 'TimUntersberger/neogit', dependencies = { 'nvim-lua/plenary.nvim' } },
  {
    'pwntester/octo.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      require('octo').setup()
    end,
  },
}
