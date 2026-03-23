-- stylua: ignore
return {
  { 'echasnovski/mini.bufremove', version = '*' },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {
      check_ts = true,
      enable_check_bracket_line = false,
      disable_filetype = { 'TelescopePrompt', 'FzfLua' },
    },
  },
  { 'numToStr/Comment.nvim', opts = {} },
  { 'kylechui/nvim-surround', version = '*', opts = {} },
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {},
    keys = {
      { 's', mode = { 'n', 'x', 'o' }, function() require('flash').jump() end, desc = 'Flash' },
      { 'S', mode = { 'n', 'x', 'o' }, function() require('flash').treesitter() end, desc = 'Flash Treesitter' },
      { 'r', mode = 'o', function() require('flash').remote() end, desc = 'Remote Flash' },
      { 'R', mode = { 'o', 'x' }, function() require('flash').treesitter_search() end, desc = 'Treesitter Search' },
    },
  },
  { 'mg979/vim-visual-multi' },
}
