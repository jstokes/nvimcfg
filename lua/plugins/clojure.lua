return {
  {
    'Olical/conjure',
    ft = { 'clojure', 'fennel' },
    init = function()
      -- Configure Conjure before it loads
      vim.g['conjure#mapping#prefix'] = '<leader>m'
      vim.g['conjure#client#clojure#nrepl#eval#pretty_print'] = true
      vim.g['conjure#completion#omnifunc'] = 'ConjureOmnifunc'
    end,
  },
  {
    'guns/vim-sexp',
    ft = { 'clojure', 'scheme', 'lisp', 'fennel' },
    config = function()
      local map = vim.keymap.set
      local remap = { remap = true, silent = true }
      -- Core SEXP editing operations
      map('n', '<leader>ks', '<Plug>(sexp_capture_next_element)', vim.tbl_extend('force', remap, { desc = 'Slurp forward' }))
      -- Note: <leader>kS is used for splice below to match your existing config (overrides "slurp backward")
      map('n', '<leader>kbl', '<Plug>(sexp_emit_tail_element)', vim.tbl_extend('force', remap, { desc = 'Barf forward (emit tail)' }))
      map('n', '<leader>kbh', '<Plug>(sexp_emit_head_element)', vim.tbl_extend('force', remap, { desc = 'Barf backward (emit head)' }))
      map('n', '<leader>kr', '<Plug>(sexp_raise)', vim.tbl_extend('force', remap, { desc = 'Raise' }))
      map('n', '<leader>kS', '<Plug>(sexp_splice)', vim.tbl_extend('force', remap, { desc = 'Splice (unwrap)' }))
      map('n', '<leader>kw(', '<Plug>(sexp_wrap_round)', vim.tbl_extend('force', remap, { desc = 'Wrap with ()' }))
      map('n', '<leader>kw[', '<Plug>(sexp_wrap_square)', vim.tbl_extend('force', remap, { desc = 'Wrap with []' }))
      map('n', '<leader>kw{', '<Plug>(sexp_wrap_curly)', vim.tbl_extend('force', remap, { desc = 'Wrap with {}' }))
      map('n', '<leader>ktl', '<Plug>(sexp_swap_element_forward)', vim.tbl_extend('force', remap, { desc = 'Transpose element forward' }))
      map('n', '<leader>kth', '<Plug>(sexp_swap_element_backward)', vim.tbl_extend('force', remap, { desc = 'Transpose element backward' }))
      map('n', '<leader>ktL', '<Plug>(sexp_swap_list_forward)', vim.tbl_extend('force', remap, { desc = 'Transpose list forward' }))
      map('n', '<leader>ktH', '<Plug>(sexp_swap_list_backward)', vim.tbl_extend('force', remap, { desc = 'Transpose list backward' }))
      map('n', '<leader>k]', '<Plug>(sexp_move_to_next_element)', vim.tbl_extend('force', remap, { desc = 'Next element' }))
      map('n', '<leader>k[', '<Plug>(sexp_move_to_prev_element)', vim.tbl_extend('force', remap, { desc = 'Prev element' }))
      map('n', '<leader>k>', '<Plug>(sexp_move_to_next_top_element)', vim.tbl_extend('force', remap, { desc = 'Next top element' }))
      map('n', '<leader>k<', '<Plug>(sexp_move_to_prev_top_element)', vim.tbl_extend('force', remap, { desc = 'Prev top element' }))
      map('x', '<leader>kr', '<Plug>(sexp_raise)', vim.tbl_extend('force', remap, { desc = 'Raise (visual)' }))
      map('x', '<leader>kw(', '<Plug>(sexp_wrap_round)', vim.tbl_extend('force', remap, { desc = 'Wrap () (visual)' }))
      map('x', '<leader>kw[', '<Plug>(sexp_wrap_square)', vim.tbl_extend('force', remap, { desc = 'Wrap [] (visual)' }))
      map('x', '<leader>kw{', '<Plug>(sexp_wrap_curly)', vim.tbl_extend('force', remap, { desc = 'Wrap {} (visual)' }))
    end,
  },
  { 'tpope/vim-sexp-mappings-for-regular-people', ft = { 'clojure', 'scheme', 'lisp', 'fennel' } },
}
