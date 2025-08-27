return {
  {
    'julienvincent/nvim-paredit',
    ft = { 'clojure', 'fennel', 'scheme', 'lisp' },
    config = function()
      local ok, paredit = pcall(require, 'nvim-paredit')
      if ok then
        paredit.setup({ use_default_keys = false })
      else
        vim.notify('nvim-paredit not available', vim.log.levels.WARN)
      end
      -- nvim-paredit keymaps under <leader>k to mirror Doom
      if ok then
        local map = vim.keymap.set
        local function n(lhs, rhs, desc)
          map('n', lhs, rhs, { silent = true, desc = desc })
        end
        local a = paredit.api
        -- Slurp/Barf
        if a.slurp_forwards then n('<leader>ks', a.slurp_forwards, 'Slurp forward') end
        if a.slurp_backwards then n('<leader>kS', a.slurp_backwards, 'Slurp backward') end
        -- Splice (unwrap)
        if a.unwrap_form_under_cursor then n('<leader>kS', a.unwrap_form_under_cursor, 'Splice (unwrap)') end
        -- Splice killing backward/forward (implement via small glue)
        local function splice_killing_backward()
          local cur = vim.api.nvim_win_get_cursor(0)
          if a.move_to_parent_form_start then a.move_to_parent_form_start() end
          local head = vim.api.nvim_win_get_cursor(0)
          -- compute the position one character before the original cursor (cross-line aware)
          local prev = { cur[1], cur[2] }
          if prev[2] > 0 then
            prev[2] = prev[2] - 1
          else
            if prev[1] > 1 then
              local prev_line = vim.api.nvim_buf_get_lines(0, prev[1]-2, prev[1]-1, true)[1] or ""
              prev = { prev[1]-1, #prev_line }
            end
          end
          local function before(p, q)
            return (p[1] < q[1]) or (p[1] == q[1] and p[2] < q[2])
          end
          -- delete from max(head, cur-1) to head (inclusive), but never beyond head
          if not before(prev, head) then
            vim.api.nvim_win_set_cursor(0, head)
            vim.cmd('normal! v')
            vim.api.nvim_win_set_cursor(0, prev)
            vim.cmd('normal! d')
          end
          if a.unwrap_form_under_cursor then a.unwrap_form_under_cursor() end
        end
        local function splice_killing_forward()
          local cur = vim.api.nvim_win_get_cursor(0)
          if a.move_to_parent_form_end then a.move_to_parent_form_end() end
          local tail = vim.api.nvim_win_get_cursor(0)
          -- compute the position one character after the original cursor (cross-line aware)
          local nextp = { cur[1], cur[2] }
          local line = vim.api.nvim_buf_get_lines(0, nextp[1]-1, nextp[1], true)[1] or ""
          if nextp[2] < #line then
            nextp[2] = nextp[2] + 1
          else
            local lastline = vim.api.nvim_buf_line_count(0)
            if nextp[1] < lastline then
              nextp = { nextp[1]+1, 0 }
            end
          end
          local function before(p, q)
            return (p[1] < q[1]) or (p[1] == q[1] and p[2] < q[2])
          end
          -- delete from next (exclusive of char under cursor) to tail, but never beyond tail
          if before(nextp, tail) then
            vim.api.nvim_win_set_cursor(0, nextp)
            vim.cmd('normal! v')
            vim.api.nvim_win_set_cursor(0, tail)
            vim.cmd('normal! d')
          end
          if a.unwrap_form_under_cursor then a.unwrap_form_under_cursor() end
        end
        n('<leader>kE', splice_killing_backward, 'Splice killing backward')
        n('<leader>ke', splice_killing_forward, 'Splice killing forward')
        -- Barf
        if a.barf_forwards then n('<leader>kbl', a.barf_forwards, 'Barf forward') end
        if a.barf_backwards then n('<leader>kbh', a.barf_backwards, 'Barf backward') end
        -- Raise
        if a.raise_sexp then n('<leader>kr', a.raise_sexp, 'Raise') end
        -- Wraps
        if a.wrap_round then n('<leader>kw(', a.wrap_round, 'Wrap with ()') end
        if a.wrap_square then n('<leader>kw[', a.wrap_square, 'Wrap with []') end
        if a.wrap_curly then n('<leader>kw{', a.wrap_curly, 'Wrap with {}') end
        -- Transpose/Swap
        if a.transpose then n('<leader>ktl', function() a.transpose('forwards', 'element') end, 'Transpose element forward') end
        if a.transpose then n('<leader>kth', function() a.transpose('backwards', 'element') end, 'Transpose element backward') end
        if a.transpose then n('<leader>ktL', function() a.transpose('forwards', 'list') end, 'Transpose list forward') end
        if a.transpose then n('<leader>ktH', function() a.transpose('backwards', 'list') end, 'Transpose list backward') end
        -- Convolute (if available)
        if a.convolute then n('<leader>kc', a.convolute, 'Convolute') end
      end
    end,
  },
}
