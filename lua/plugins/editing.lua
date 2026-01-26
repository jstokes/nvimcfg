-- stylua: ignore
return {
  { 'echasnovski/mini.bufremove', version = '*' },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      local npairs = require('nvim-autopairs')
      npairs.setup({
        check_ts = true,
        enable_check_bracket_line = false,
        disable_filetype = { 'TelescopePrompt' },
      })
      local ok_cmp, cmp = pcall(require, 'cmp')
      if ok_cmp then
        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
      end
    end,
  },
  { 'numToStr/Comment.nvim', opts = {} },
  { 'kylechui/nvim-surround', version = '*', opts = {} },
  { 'ggandor/leap.nvim', opts = {} },
  { 'mg979/vim-visual-multi' },
}
