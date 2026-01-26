return {
  {
    'julienvincent/nvim-paredit',
    ft = { 'clojure', 'fennel', 'scheme', 'lisp' },
    config = function()
      local paredit = require('nvim-paredit')
      paredit.setup({
        keys = {
          -- Slurp/Barf with leader keys
          ['<leader>ks'] = { paredit.api.slurp_forwards, 'Slurp forward' },
          ['<leader>kS'] = { paredit.api.slurp_backwards, 'Slurp backward' },
          ['<leader>kb'] = { paredit.api.barf_forwards, 'Barf forward' },
          ['<leader>kB'] = { paredit.api.barf_backwards, 'Barf backward' },

          -- "Sexp bindings for humans" - arrow keys with Alt
          ['<M-Right>'] = { paredit.api.slurp_forwards, 'Slurp forward' },
          ['<M-Left>'] = { paredit.api.barf_forwards, 'Barf forward' },
          ['<M-S-Left>'] = { paredit.api.slurp_backwards, 'Slurp backward' },
          ['<M-S-Right>'] = { paredit.api.barf_backwards, 'Barf backward' },

          -- Splice/Raise
          ['<leader>ku'] = { paredit.api.unwrap_form_under_cursor, 'Splice (unwrap)' },
          ['<leader>kr'] = { paredit.api.raise_element, 'Raise element' },
          ['<leader>kR'] = { paredit.api.raise_form, 'Raise form' },

          -- Drag elements/forms
          ['<leader>ktl'] = { paredit.api.drag_element_forwards, 'Drag element forward' },
          ['<leader>kth'] = { paredit.api.drag_element_backwards, 'Drag element backward' },
          ['<leader>ktL'] = { paredit.api.drag_form_forwards, 'Drag form forward' },
          ['<leader>ktH'] = { paredit.api.drag_form_backwards, 'Drag form backward' },
        },
      })

      -- Wrap bindings (need function wrapper for arguments)
      local map = vim.keymap.set
      map('n', '<leader>kw(', function() paredit.api.wrap_element_under_cursor('(', ')') end, { desc = 'Wrap ()' })
      map('n', '<leader>kw[', function() paredit.api.wrap_element_under_cursor('[', ']') end, { desc = 'Wrap []' })
      map('n', '<leader>kw{', function() paredit.api.wrap_element_under_cursor('{', '}') end, { desc = 'Wrap {}' })
    end,
  },
}
