return {
  {
    'nvim-neotest/neotest',
    lazy = true,
    cmd = { 'Neotest' },
    keys = {
      { '<leader>tn', desc = 'Test: Run nearest' },
      { '<leader>tf', desc = 'Test: Run file' },
      { '<leader>tl', desc = 'Test: Run last' },
      { '<leader>tS', desc = 'Test: Stop' },
      { '<leader>ts', desc = 'Test: Toggle summary' },
      { '<leader>to', desc = 'Test: Open output' },
      { '<leader>tO', desc = 'Test: Toggle output panel' },
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'nvim-neotest/nvim-nio',
      'vim-test/vim-test',
      'nvim-neotest/neotest-vim-test',
    },
    init = function()
      -- Ensure vim-test uses Leiningen and runs inside Neovim
      vim.g['test#clojure#runner'] = 'lein'
      vim.g['test#strategy'] = 'neovim'
    end,
    config = function()
      local neotest = require('neotest')
      neotest.setup({
        adapters = {
          require('neotest-vim-test')({
            allow_mixed_filetypes = true,
            -- Limit vim-test adapter focus primarily to Clojure
            ignore_file_types = { 'python', 'javascript', 'typescript', 'go', 'rust', 'ruby', 'lua' },
          }),
        },
        quickfix = { enabled = true, open = false },
        diagnostic = { enabled = true },
        output = { open_on_run = false },
        floating = { border = 'rounded' },
      })

      -- Keymaps (kept local to this plugin to avoid conflicts)
      local map = vim.keymap.set
      local base = { silent = true, noremap = true }
      map('n', '<leader>tn', function() neotest.run.run() end, vim.tbl_extend('force', base, { desc = 'Test: Run nearest' }))
      map('n', '<leader>tf', function() neotest.run.run(vim.fn.expand('%')) end, vim.tbl_extend('force', base, { desc = 'Test: Run file' }))
      map('n', '<leader>tl', function() neotest.run.run_last() end, vim.tbl_extend('force', base, { desc = 'Test: Run last' }))
      map('n', '<leader>tS', function() neotest.run.stop() end, vim.tbl_extend('force', base, { desc = 'Test: Stop' }))
      map('n', '<leader>ts', function() neotest.summary.toggle() end, vim.tbl_extend('force', base, { desc = 'Test: Toggle summary' }))
      map('n', '<leader>to', function() neotest.output.open({ enter = true, short = true }) end, vim.tbl_extend('force', base, { desc = 'Test: Open output (short)' }))
      map('n', '<leader>tO', function() neotest.output_panel.toggle() end, vim.tbl_extend('force', base, { desc = 'Test: Toggle output panel' }))
    end,
  },
}
