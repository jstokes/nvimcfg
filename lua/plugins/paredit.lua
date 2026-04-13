return {
  {
    'julienvincent/nvim-paredit',
    ft = { 'clojure', 'fennel', 'scheme', 'lisp' },
    config = function()
      local paredit = require('nvim-paredit')

      -- Raise the nearest form under cursor, replacing only its direct parent.
      -- e.g. (baz (foo |(bar [a b c]))) -> (baz (bar [a b c]))
      local function raise_inner_form()
        local ts_context = require('nvim-paredit.treesitter.context')
        local ts_forms = require('nvim-paredit.treesitter.forms')
        local ts_utils = require('nvim-paredit.treesitter.utils')

        local context = ts_context.create_context()
        if not context then return end

        local form = ts_forms.find_nearest_form(context.node, context)
        if not form then return end

        local parent = form:parent()
        if not parent or ts_utils.is_document_root(parent) then return end

        local replace_text = vim.treesitter.get_node_text(form, 0)
        local parent_range = { parent:range() }
        vim.api.nvim_buf_set_text(
          0,
          parent_range[1], parent_range[2],
          parent_range[3], parent_range[4],
          vim.fn.split(replace_text, '\n')
        )
        vim.api.nvim_win_set_cursor(0, { parent_range[1] + 1, parent_range[2] })
      end

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
          ['<leader>kE'] = { raise_inner_form, 'Raise inner form (Doom-style)' },

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
