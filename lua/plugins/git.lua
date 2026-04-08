return {
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      sign_priority = 5,
      signcolumn = false, -- default off, toggle with <leader>gS
      numhl = true,       -- subtle: highlight only the line number for changes
      linehl = false,
      word_diff = false,
      signs = {
        add          = { text = '│' },
        change       = { text = '│' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
      },
    },
    config = function(_, opts)
      require('gitsigns').setup(opts)
      -- Toggle signs with <leader>gS
      vim.keymap.set('n', '<leader>gS', function()
        local gs = require('gitsigns')
        gs.toggle_signs()
        local current = vim.opt.signcolumn:get()
        vim.opt.signcolumn = current == 'no' and 'yes' or 'no'
      end, { desc = 'Toggle git signs' })
    end,
  },
  { 'ruifm/gitlinker.nvim', dependencies = { 'nvim-lua/plenary.nvim' }, opts = {} },
  {
    'TimUntersberger/neogit',
    dependencies = { 'nvim-lua/plenary.nvim', 'sindrets/diffview.nvim' },
    cmd = 'Neogit',
    opts = {
      integrations = { diffview = true },
    },
  },
  {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory', 'DiffviewClose' },
    opts = {},
    keys = {
      { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'Diffview: Open' },
      { '<leader>gD', '<cmd>DiffviewFileHistory %<cr>', desc = 'Diffview: File history' },
      { '<leader>gq', '<cmd>DiffviewClose<cr>', desc = 'Diffview: Close' },
    },
  },
  {
    'ThePrimeagen/git-worktree.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    config = function()
      local ok, Worktree = pcall(require, 'git-worktree')
      if not ok then return end
      Worktree.setup({
        change_directory_command = 'cd',
        update_on_change = true,
        update_on_change_command = 'e .',
        clearjumps_on_change = true,
        autopush = false,
      })
      -- Load Telescope extension if available
      pcall(function()
        require('telescope').load_extension('git_worktree')
      end)

      -- Helper: repo root
      local function git_root()
        local result = vim.fn.systemlist('git rev-parse --show-toplevel')
        if vim.v.shell_error ~= 0 or not result or not result[1] or result[1] == '' then
          return nil
        end
        return result[1]
      end

      -- Create worktree at .trees/{branch}
      local function create_trees_worktree(branch, upstream)
        local root = git_root()
        if not root then
          vim.notify('Not inside a Git repository', vim.log.levels.ERROR)
          return
        end
        if not branch or branch == '' then
          vim.notify('Branch name is required', vim.log.levels.WARN)
          return
        end
        local trees_dir = root .. '/.trees'
        if vim.fn.isdirectory(trees_dir) == 0 then
          vim.fn.mkdir(trees_dir, 'p')
        end
        local path = trees_dir .. '/' .. branch
        local parent = vim.fn.fnamemodify(path, ':h')
        if vim.fn.isdirectory(parent) == 0 then
          vim.fn.mkdir(parent, 'p')
        end

        -- Determine if branch already exists locally
        local function cmd_ok(cmd)
          vim.fn.system(cmd)
          return vim.v.shell_error == 0
        end
        local exists_local = cmd_ok('git show-ref --verify --quiet "refs/heads/' .. branch .. '"')

        -- Decide upstream/base:
        -- - If no base provided and branch doesn't exist locally → use origin HEAD (e.g. origin/main), fallback to origin/main/master
        -- - If branch exists locally → ignore base (checkout existing)
        local final_upstream = upstream
        if exists_local then
          final_upstream = nil
        else
          if final_upstream == nil or final_upstream == '' then
            -- Try to detect remote default branch (origin/HEAD)
            local head = vim.fn.systemlist('git symbolic-ref -q --short refs/remotes/origin/HEAD')
            if vim.v.shell_error == 0 and head and head[1] and head[1] ~= '' then
              final_upstream = head[1]
            else
              -- Fallbacks
              if cmd_ok('git show-ref --verify --quiet "refs/remotes/origin/main"') then
                final_upstream = 'origin/main'
              elseif cmd_ok('git show-ref --verify --quiet "refs/remotes/origin/master"') then
                final_upstream = 'origin/master'
              else
                final_upstream = nil
              end
            end
          else
            -- Use provided base for new branch
            final_upstream = upstream
          end
        end

        Worktree.create_worktree(path, branch, final_upstream)
      end

      -- :WorktreeCreateTrees [branch] [upstream]
      vim.api.nvim_create_user_command('WorktreeCreateTrees', function(opts)
        local branch = opts.fargs[1] or vim.fn.input('Branch name: ')
        if not branch or branch == '' then
          vim.notify('Branch name is required', vim.log.levels.WARN)
          return
        end
        local upstream = opts.fargs[2]
        if upstream == nil then
          local input = vim.fn.input('Base (optional, e.g. origin/main): ')
          if input ~= nil and input ~= '' then upstream = input end
        end
        create_trees_worktree(branch, upstream)
      end, { nargs = '*' })
    end,
  },
  {
    'pwntester/octo.nvim',
    cmd = 'Octo',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      require('octo').setup({
        mappings = {
          submit_win = {
            approve_review = { lhs = '<leader>sa', desc = 'approve review' },
            comment_review = { lhs = '<leader>sc', desc = 'comment review' },
            request_changes = { lhs = '<leader>sr', desc = 'request changes' },
          },
        },
      })
    end,
  },
}
