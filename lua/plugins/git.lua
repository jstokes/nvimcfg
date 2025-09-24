return {
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      sign_priority = 5,
      signcolumn = false, -- do not use the signcolumn at all
      numhl = true,       -- subtle: highlight only the line number for changes
      linehl = false,
      word_diff = false,
      signs = {
        add          = { text = '' },
        change       = { text = '' },
        delete       = { text = '' },
        topdelete    = { text = '' },
        changedelete = { text = '' },
        untracked    = { text = '' },
      },
      -- You can further reduce noise by linking numhl to LineNr in your colorscheme setup
    },
    config = function(_, opts)
      require('gitsigns').setup(opts)
      -- Optional: make number highlights as subtle as regular line numbers
      vim.api.nvim_set_hl(0, 'GitSignsAddNr',    { link = 'LineNr' })
      vim.api.nvim_set_hl(0, 'GitSignsChangeNr', { link = 'LineNr' })
      vim.api.nvim_set_hl(0, 'GitSignsDeleteNr', { link = 'LineNr' })
    end,
  },
  { 'ruifm/gitlinker.nvim', dependencies = { 'nvim-lua/plenary.nvim' }, opts = {} },
  { 'TimUntersberger/neogit', dependencies = { 'nvim-lua/plenary.nvim' } },
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
        -- - If no base provided and branch doesn't exist locally → use origin/main
        -- - If branch exists locally → ignore base (checkout existing)
        local final_upstream = upstream
        if final_upstream == nil or final_upstream == '' then
          if not exists_local then
            final_upstream = 'origin/main'
          else
            final_upstream = nil
          end
        else
          if exists_local then
            vim.notify('Branch exists; ignoring base "' .. tostring(final_upstream) .. '"', vim.log.levels.INFO)
            final_upstream = nil
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

      -- If you want Neogit to open automatically on switch, uncomment below:
      -- Worktree.on_tree_change(function(op)
      --   if op == Worktree.Operations.Switch then
      --     vim.schedule(function()
      --       local ok_ng, neogit = pcall(require, 'neogit')
      --       if ok_ng then neogit.open({ kind = 'tab' }) end
      --     end)
      --   end
      -- end)
    end,
  },
  {
    'pwntester/octo.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      require('octo').setup()
    end,
  },
}
