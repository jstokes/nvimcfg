return {
  { 'lewis6991/gitsigns.nvim', opts = { sign_priority = 5 } },
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
