return {
  {
    'azorng/goose.nvim',
    config = function()
      local ok, wk = pcall(require, 'which-key')
      if ok then
        wk.add { { '<leader>G', group = 'Goose' } }
      end
      require('goose').setup {}
    end,
    dependencies = {
      'folke/which-key.nvim',
      'nvim-lua/plenary.nvim',
      {
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          anti_conceal = { enabled = false },
        },
      },
    },
  },
}
