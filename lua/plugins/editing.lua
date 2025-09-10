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
      -- Integrate with nvim-cmp if available
      local ok_cmp, cmp = pcall(require, 'cmp')
      if ok_cmp then
        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
      end
      -- Extra rules to be more aggressive in Lisp forms (Clojure, etc.)
      local Rule = require('nvim-autopairs.rule')
      local lisp_fts = { 'clojure', 'fennel', 'scheme', 'lisp' }
      for _, ft in ipairs(lisp_fts) do
        npairs.add_rules({
          Rule('(', ')', ft):with_pair(function() return true end),
          Rule('[', ']', ft):with_pair(function() return true end),
          Rule('{', '}', ft):with_pair(function() return true end),
        })
      end
    end,
  },
  { 'numToStr/Comment.nvim', opts = {} },
  { 'kylechui/nvim-surround', version = '*', opts = {} },
  { 'ggandor/leap.nvim', opts = {} },
  { 'mg979/vim-visual-multi' },
}
