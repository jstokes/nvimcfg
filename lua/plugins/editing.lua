return {
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      require('nvim-autopairs').setup({})
    end,
  },
  { 'numToStr/Comment.nvim', opts = {} },
  { 'kylechui/nvim-surround', version = '*', opts = {} },
  { 'ggandor/leap.nvim', opts = {} },
  { 'mg979/vim-visual-multi' },
}
