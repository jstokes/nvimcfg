-- Session persistence mappings
local has_persist, persistence = pcall(require, 'persistence')
if has_persist then
  vim.keymap.set('n', '<leader>qs', function() persistence.load() end, { desc = 'Session: restore' })
  vim.keymap.set('n', '<leader>ql', function() persistence.load({ last = true }) end, { desc = 'Session: restore last' })
  vim.keymap.set('n', '<leader>qd', function() persistence.stop() end, { desc = 'Session: stop saving' })
end

-- Insert-mode convenience
vim.keymap.set('i', 'fd', '<Esc>', { desc = 'Escape insert', noremap = true })

-- Emacs-style file open: C-x C-f (normal/insert)
local function open_file_browser_cwd()
  local fb_ok = pcall(function()
    require('telescope').extensions.file_browser.file_browser({
      cwd = vim.fn.expand('%:p:h'),
      select_buffer = true,
      hidden = true,
      respect_gitignore = false,
    })
  end)
  if not fb_ok then
    -- Fallback to find_files in current dir
    require('telescope.builtin').find_files({ cwd = vim.fn.expand('%:p:h') })
  end
end

vim.keymap.set('n', '<C-x><C-f>', open_file_browser_cwd, { desc = 'Open file (Emacs C-x C-f)' })
vim.keymap.set('i', '<C-x><C-f>', function()
  open_file_browser_cwd()
end, { desc = 'Open file (Emacs C-x C-f)' })


-- General which-key groups
local ok_wk, wk = pcall(require, 'which-key')
if ok_wk then
  wk.add({
    { '<leader>f', group = 'Files' },
    { '<leader>fs', desc = 'Save file' },
    { '<leader>b', group = 'Buffers' },
    { '<leader>p', group = 'Project' },
    { '<leader>g', group = 'Git' },
    { '<leader>s', group = 'Search' },
    { '<leader>t', group = 'Toggle' },
    { '<leader>w', group = 'Windows' },
    { '<leader>c', group = 'Code' },
  })
  wk.add({
    { '<leader>k', group = 'Lisp (sexp)' },
    { '<leader>kb', group = 'Barf (emit)' },
    { '<leader>kw', group = 'Wrap' },
    { '<leader>kt', group = 'Transpose' },
    { '<leader>k]', desc = 'Next element' },
    { '<leader>k[', desc = 'Prev element' },
    { '<leader>k>', desc = 'Next list' },
    { '<leader>k<', desc = 'Prev list' },
  })
  wk.add({
    { '<leader>m', group = 'Clojure' },
    { '<leader>me', group = 'Eval' },
    { '<leader>mef', desc = 'Eval file' },
    { '<leader>mee', desc = 'Eval current form' },
    { '<leader>mer', desc = 'Eval root form' },
    { '<leader>mes', desc = 'Eval visual', mode = 'v' },
    { '<leader>mel', desc = 'Open log split' },
  })
end

local map = vim.keymap.set
-- Telescope (wrap to lazy-require on execution)
map('n', '<leader>ff', function() require('telescope.builtin').find_files() end, { desc = 'Find files' })
map('n', '<leader>fg', function() require('telescope.builtin').live_grep() end, { desc = 'Live grep' })
map('n', '<leader>fb', function() require('telescope.builtin').buffers() end, { desc = 'Buffers' })
map('n', '<leader>fh', function() require('telescope.builtin').help_tags() end, { desc = 'Help' })
map('n', '<leader>/', function() require('telescope.builtin').live_grep() end, { desc = 'Live grep (project)' })
map('n', '<leader>sp', function()
  local ok = pcall(function() require('telescope').extensions.project.project() end)
  if not ok then vim.notify('telescope-project not loaded', vim.log.levels.WARN) end
end, { desc = 'Projects' })

-- Search helpers
map('n', '<leader>sc', ':nohlsearch<CR>', { desc = 'Clear search highlights' })

-- Gitsigns
map('n', '<leader>gb', function() require('gitsigns').toggle_current_line_blame() end, { desc = 'Toggle blame' })
map('n', '<leader>gp', function() require('gitsigns').preview_hunk() end, { desc = 'Preview hunk' })
map('n', '<leader>gr', function() require('gitsigns').reset_hunk() end, { desc = 'Reset hunk' })

-- Gitlinker
map('n', '<leader>gl', function()
  local ok, gitlinker = pcall(require, 'gitlinker')
  if ok then gitlinker.get_buf_range_url() else vim.notify('gitlinker not loaded', vim.log.levels.WARN) end
end, { desc = 'Copy GitHub permalink' })

-- Windows
map('n', '<leader>ws', ':split<CR>', { desc = 'Horizontal split' })
map('n', '<leader>wv', ':vsplit<CR>', { desc = 'Vertical split' })
map('n', '<leader>wd', ':close<CR>', { desc = 'Delete window' })
map('n', '<leader>wo', ':only<CR>', { desc = 'Only (close others)' })
map('n', '<leader>wh', '<C-w>h', { desc = 'Focus left' })
map('n', '<leader>wj', '<C-w>j', { desc = 'Focus down' })

-- Files
map('n', '<leader>fs', ':w<CR>', { desc = 'Save file' })
map('v', '<leader>fs', '<Esc>:w<CR>', { desc = 'Save file' })

map('n', '<leader>wk', '<C-w>k', { desc = 'Focus up' })
map('n', '<leader>wl', '<C-w>l', { desc = 'Focus right' })
map('n', '<leader>wH', '<C-w>H', { desc = 'Move to left' })
map('n', '<leader>wJ', '<C-w>J', { desc = 'Move to bottom' })
map('n', '<leader>wK', '<C-w>K', { desc = 'Move to top' })
map('n', '<leader>wL', '<C-w>L', { desc = 'Move to right' })
map('n', '<leader>w=', '<C-w>=', { desc = 'Equalize windows' })
map('n', '<leader>wx', ':xall<CR>', { desc = 'Save & exit all' })

-- Buffer
map('n', '<leader>bb', function() require('telescope.builtin').buffers() end, { desc = 'List buffers' })
map('n', '<leader>bd', ':bdelete<CR>', { desc = 'Delete buffer' })
map('n', '<leader>bk', ':bdelete!<CR>', { desc = 'Kill buffer (force)' })
map('n', '<leader>bn', ':bnext<CR>', { desc = 'Next buffer' })
map('n', '<leader>bp', ':bprevious<CR>', { desc = 'Prev buffer' })
map('n', '<leader>br', ':edit!<CR>', { desc = 'Revert buffer' })

-- Conjure Ctrl mappings (keep Emacs-like)
map('n', '<C-c><C-c>', ':ConjureEvalRootForm<CR>', { silent = true, desc = 'Eval root form under cursor' })
map('n', '<C-c><C-e>', ':ConjureEvalCurrentForm<CR>', { silent = true, desc = 'Eval form under cursor' })
map('n', '<C-c><C-k>', ':ConjureEvalFile<CR>', { silent = true, desc = 'Eval current buffer' })
map('n', '<C-c><C-z>', ':ConjureLogVSplit<CR>', { silent = true, desc = 'Toggle log (REPL view)' })
map('n', '<C-c><C-p>', function()
  vim.g["conjure#client#clojure#nrepl#eval#pretty_print"] = true
  vim.cmd('ConjureEvalRootForm')
end, { silent = true, desc = 'Pretty print current form' })
map('n', '<C-c><C-;>', ':ConjureEvalCommentCurrentForm<CR>', { silent = true, desc = 'Eval to comment' })
map('n', '<C-c><C-v>n', ':ConjureEvalFile<CR>', { silent = true, desc = 'Eval ns for current file' })
