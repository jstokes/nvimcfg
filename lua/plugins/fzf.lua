-- stylua: ignore

return {
  { 'nvim-lua/plenary.nvim', lazy = true },
  {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    cmd = 'FzfLua',
    config = function()
      local fzf = require('fzf-lua')
      fzf.setup({
        'default-title',
        winopts = {
          preview = { default = 'bat' },
        },
        fzf_opts = {
          ['--layout'] = 'reverse',
        },
        keymap = {
          fzf = {
            ['ctrl-q'] = 'select-all+accept',
          },
        },
      })
      -- Use fzf-lua for vim.ui.select (replaces telescope-ui-select)
      fzf.register_ui_select()
    end,
  },
  -- Keep telescope as lazy dependency for octo.nvim and git-worktree
  {
    'nvim-telescope/telescope.nvim',
    lazy = true,
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', cond = function() return vim.fn.executable('make') == 1 end },
    },
    config = function()
      local ok, telescope = pcall(require, 'telescope')
      if not ok then return end
      telescope.setup({
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = 'smart_case',
          },
        },
      })
      pcall(telescope.load_extension, 'fzf')
    end,
  },
}
