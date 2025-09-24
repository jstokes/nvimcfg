-- Session persistence mappings
-- stylua: ignore

-- Register Git group for which-key (including worktrees)
pcall(require, 'which-key')

-- LSP convenience mappings (global) with which-key registration under <leader>l
local function with_lsp(fn)
  return function()
    local clients = vim.lsp.get_clients and vim.lsp.get_clients({ bufnr = 0 }) or {}
    if not clients or #clients == 0 then
      vim.notify('No LSP attached for this buffer', vim.log.levels.WARN)
      return
    end
    fn()
  end
end

-- Register which-key group for LSP
local ok_wk_head, wk_head = pcall(require, 'which-key')
if ok_wk_head then
  wk_head.add({ { '<leader>l', group = 'LSP' } })
end

-- Core LSP actions
vim.keymap.set('n', '<leader>la', with_lsp(vim.lsp.buf.code_action), { desc = 'LSP: Code Action' })
vim.keymap.set('n', '<leader>lr', with_lsp(vim.lsp.buf.rename), { desc = 'LSP: Rename' })
vim.keymap.set('n', '<leader>ld', with_lsp(vim.lsp.buf.definition), { desc = 'LSP: Definition' })
vim.keymap.set('n', '<leader>lR', with_lsp(vim.lsp.buf.references), { desc = 'LSP: References' })
vim.keymap.set('n', '<leader>lh', with_lsp(vim.lsp.buf.hover), { desc = 'LSP: Hover' })
vim.keymap.set('n', '<leader>li', with_lsp(vim.lsp.buf.implementation), { desc = 'LSP: Implementation' })
vim.keymap.set('n', '<leader>lf', with_lsp(function() vim.lsp.buf.format({ async = true }) end), { desc = 'LSP: Format' })

local has_persist, persistence = pcall(require, 'persistence')
if has_persist then
  vim.keymap.set('n', '<leader>qs', function() persistence.load() end, { desc = 'Session: restore' })
  vim.keymap.set('n', '<leader>ql', function() persistence.load({ last = true }) end, { desc = 'Session: restore last' })
  vim.keymap.set('n', '<leader>qd', function() persistence.stop() end, { desc = 'Session: stop saving' })
end

-- Doom Emacs style quit
vim.keymap.set('n', '<leader>qq', ':confirm qall<CR>', { desc = 'Quit Neovim (confirm)' })

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
    { '<leader>ba', desc = 'Alternate buffer' },
    { '<leader>bb', desc = 'Buffers list' },
    { '<leader>bp', desc = 'Pick buffer' },
    { '<leader>bc', desc = 'Pick close' },
    { '<leader>bq', desc = 'Close right' },
    { '<leader>bQ', desc = 'Close left' },

    { '<leader>g', group = 'Git' },
    { '<leader>gh', group = 'GitHub (Octo)' },
    { '<leader>s', group = 'Search' },
    { '<leader>t', group = 'Toggle' },
    { '<leader>w', group = 'Windows' },
    { '<leader>c', group = 'Code' },
  })
  wk.add({
    { '<leader>gW', desc = 'Worktree: create' },
    { '<leader>gw', desc = 'Worktree: list/switch' },
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
  wk.add({ { '<leader>tL', desc = 'Toggle lint (ALE buffer)' } })
  wk.add({ { '<leader>gg', desc = 'Git status (Neogit)' } })

end

local map = vim.keymap.set
-- Telescope (wrap to lazy-require on execution)
map('n', '<leader>tL', ':ALEToggleBuffer<CR>', { desc = 'Toggle lint (ALE buffer)' })

map('n', '<leader>ff', function() require('telescope.builtin').find_files() end, { desc = 'Find files' })
if ok_wk then
  wk.add({

    { '<leader>ghl', desc = 'PR list' },
    { '<leader>gho', desc = 'PR view (current)' },
    { '<leader>ghd', desc = 'PR diff (current)' },
    { '<leader>ghr', desc = 'Review start' },
    { '<leader>ghs', desc = 'Review submit' },
    { '<leader>ghc', desc = 'Add comment' },
    { '<leader>ghi', desc = 'Issues list' },
  })
end

map('n', '<leader>fg', function() require('telescope.builtin').live_grep() end, { desc = 'Live grep' })
map('n', '<leader>fb', function() require('telescope.builtin').buffers() end, { desc = 'Buffers' })
map('n', '<leader>fh', function() require('telescope.builtin').help_tags() end, { desc = 'Help' })
-- Project-aware live grep: git root if available, else current working dir
local function project_root()
  local function try_git_root(dir)
    if not dir or dir == '' then return nil end
    local cmd = { 'git', '-C', dir, 'rev-parse', '--show-toplevel' }
    local result = vim.fn.systemlist(table.concat(cmd, ' '))
    if vim.v.shell_error == 0 and result and result[1] and result[1] ~= '' then
      return result[1]
    end
    return nil
  end
  local bufdir = vim.fn.expand('%:p:h')
  local cwd = vim.fn.getcwd()
  return try_git_root(bufdir) or try_git_root(cwd) or cwd
end

-- Prompt for a directory (default to cwd) and live_grep within it
local function grep_in_dir_prompt()
  local default = vim.fn.getcwd()
  local dir = vim.fn.input('Search directory: ', default, 'dir')
  if dir == nil or dir == '' then dir = default end
  dir = vim.fn.expand(dir)
  if vim.fn.isdirectory(dir) == 0 then
    vim.notify('Not a directory: ' .. dir, vim.log.levels.ERROR)
    return
  end
  require('telescope.builtin').live_grep({ cwd = dir })
end


-- Telescope: quick recent-buffers switcher
vim.keymap.set('n', '<leader>,', function()
  require('telescope.builtin').buffers({ sort_lastused = true, ignore_current_buffer = true })
end, { desc = 'Switch buffer (recent first)' })

-- Alternate buffer toggle
vim.keymap.set('n', '<leader>ba', '<C-^>', { desc = 'Alternate buffer' })

-- Bufferline keymaps (if plugin is installed)
vim.keymap.set('n', '<S-l>', ':BufferLineCycleNext<CR>', { desc = 'Next buffer (bufferline)' })
vim.keymap.set('n', '<S-h>', ':BufferLineCyclePrev<CR>', { desc = 'Prev buffer (bufferline)' })
vim.keymap.set('n', '<leader>bp', ':BufferLinePick<CR>', { desc = 'Pick buffer (bufferline)' })
vim.keymap.set('n', '<leader>bc', ':BufferLinePickClose<CR>', { desc = 'Pick buffer to close (bufferline)' })
vim.keymap.set('n', '<leader>bq', ':BufferLineCloseRight<CR>', { desc = 'Close buffers to the right' })
vim.keymap.set('n', '<leader>bQ', ':BufferLineCloseLeft<CR>', { desc = 'Close buffers to the left' })

-- Mini.bufremove-backed deletes if available
local ok_brm, brm = pcall(require, 'mini.bufremove')
if ok_brm then
  vim.keymap.set('n', '<leader>bd', function() brm.delete(0, false) end, { desc = 'Delete buffer (preserve layout)' })
  vim.keymap.set('n', '<leader>bk', function() brm.delete(0, true) end, { desc = 'Kill buffer (force)' })
end

map('n', '<leader>/', function()
  local root = project_root()
  require('telescope.builtin').live_grep({ cwd = root })
end, { desc = 'Live grep (project root)' })
map('n', '<leader>sp', function()
  local ok = pcall(function() require('telescope').extensions.project.project() end)
  if not ok then vim.notify('telescope-project not loaded', vim.log.levels.WARN) end
end, { desc = 'Projects' })

-- Search helpers
map('n', '<leader>sc', ':nohlsearch<CR>', { desc = 'Clear search highlights' })

-- Doom-style: <leader>sf → prompt for directory and find files there
vim.keymap.set('n', '<leader>sf', function()
  local default = vim.fn.getcwd()
  local dir = vim.fn.input('Find files in dir: ', default, 'dir')
  if dir == nil or dir == '' then dir = default end
  dir = vim.fn.expand(dir)
  if vim.fn.isdirectory(dir) == 0 then
    vim.notify('Not a directory: ' .. dir, vim.log.levels.ERROR)
    return
  end
  require('telescope.builtin').find_files({ cwd = dir, hidden = true })
end, { desc = 'Files: find in directory…' })

-- Gitsigns
map('n', '<leader>gb', function() require('gitsigns').toggle_current_line_blame() end, { desc = 'Toggle blame' })
map('n', '<leader>gp', function() require('gitsigns').preview_hunk() end, { desc = 'Preview hunk' })
map('n', '<leader>gr', function() require('gitsigns').reset_hunk() end, { desc = 'Reset hunk' })
-- Command palette and builtins
vim.keymap.set('n', '<leader>p', function() require('telescope.builtin').commands() end, { desc = 'Command Palette' })
vim.keymap.set('n', '<leader>?', function() require('telescope.builtin').builtin() end, { desc = 'Telescope builtins' })


-- Gitlinker
map('n', '<leader>gl', function()
  local ok, gitlinker = pcall(require, 'gitlinker')
  if ok then gitlinker.get_buf_range_url() else vim.notify('gitlinker not loaded', vim.log.levels.WARN) end
end, { desc = 'Copy GitHub permalink' })
-- Git worktrees via Telescope
map('n', '<leader>gw', function()
  local ok = pcall(function()
    require('telescope').extensions.git_worktree.git_worktrees()
  end)
  if not ok then vim.notify('git-worktree or telescope not loaded', vim.log.levels.WARN) end
end, { desc = 'Worktree: list/switch' })
map('n', '<leader>gW', function()
  local ok = pcall(function()
    vim.cmd('WorktreeCreateTrees')
  end)
  if not ok then vim.notify('git-worktree not loaded', vim.log.levels.WARN) end
end, { desc = 'Worktree: create (.trees/{branch})' })
-- Neogit (status)
map('n', '<leader>gg', function()
  local ok, neogit = pcall(require, 'neogit')
  if ok then neogit.open({ kind = 'tab' }) else vim.notify('neogit not loaded', vim.log.levels.WARN) end
end, { desc = 'Git status (Neogit)' })


-- Windows
map('n', '<leader>ws', ':split<CR>', { desc = 'Horizontal split' })
map('n', '<leader>wv', ':vsplit<CR>', { desc = 'Vertical split' })
map('n', '<leader>wd', ':close<CR>', { desc = 'Delete window' })
map('n', '<leader>wo', ':only<CR>', { desc = 'Only (close others)' })
map('n', '<leader>wh', '<C-w>h', { desc = 'Focus left' })
map('n', '<leader>wj', '<C-w>j', { desc = 'Focus down' })

-- Files
map('n', '<leader>fs', ':w<CR>', { desc = 'Save file' })
-- Doom-style: <leader>sD → prompt for directory and grep there
vim.keymap.set('n', '<leader>sD', grep_in_dir_prompt, { desc = 'Search: grep in directory…' })

map('v', '<leader>fs', '<Esc>:w<CR>', { desc = 'Save file' })

map('n', '<leader>wk', '<C-w>k', { desc = 'Focus up' })
map('n', '<leader>wl', '<C-w>l', { desc = 'Focus right' })
map('n', '<leader>wH', '<C-w>H', { desc = 'Move to left' })
map('n', '<leader>wJ', '<C-w>J', { desc = 'Move to bottom' })
map('n', '<leader>wK', '<C-w>K', { desc = 'Move to top' })
map('n', '<leader>wL', '<C-w>L', { desc = 'Move to right' })
map('n', '<leader>w=', '<C-w>=', { desc = 'Equalize windows' })
map('n', '<leader>wx', ':xall<CR>', { desc = 'Save & exit all' })
-- Octo (GitHub) mappings
map('n', '<leader>ghl', ':Octo pr list<CR>', { desc = 'PR list' })
map('n', '<leader>gho', ':Octo pr view<CR>', { desc = 'PR view (current)' })
map('n', '<leader>ghd', ':Octo pr diff<CR>', { desc = 'PR diff (current)' })
map('n', '<leader>ghr', ':Octo review start<CR>', { desc = 'Review start' })
map('n', '<leader>ghs', ':Octo review submit<CR>', { desc = 'Review submit' })
map('n', '<leader>ghc', ':Octo comment add<CR>', { desc = 'Add comment' })
map('n', '<leader>ghi', ':Octo issue list<CR>', { desc = 'Issues list' })


-- Buffer
map('n', '<leader>bb', function() require('telescope.builtin').buffers() end, { desc = 'List buffers' })
 do
  local ok_brm2, brm2 = pcall(require, 'mini.bufremove')
  if ok_brm2 then
    map('n', '<leader>bd', function() brm2.delete(0, false) end, { desc = 'Delete buffer (preserve layout)' })
    map('n', '<leader>bk', function() brm2.delete(0, true) end, { desc = 'Kill buffer (force)' })
  else
    map('n', '<leader>bd', ':bdelete<CR>', { desc = 'Delete buffer' })
    map('n', '<leader>bk', ':bdelete!<CR>', { desc = 'Kill buffer (force)' })
  end
end
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

-- Diagnostics mappings and WhichKey group under <leader>d
local ok_wk_diag_group, wk_diag_group = pcall(require, 'which-key')
if ok_wk_diag_group then
  wk_diag_group.add({ { '<leader>d', group = 'Diagnostics' } })
end

-- Line diagnostic
vim.keymap.set('n', '<leader>de', function()
  vim.diagnostic.open_float(nil, { border = 'rounded', source = 'if_many' })
end, { desc = 'Line diagnostic' })

-- Next diagnostic
vim.keymap.set('n', '<leader>dn', function()
  vim.diagnostic.goto_next({ float = { border = 'rounded', source = 'if_many' } })
end, { desc = 'Next diagnostic' })

-- Prev diagnostic
vim.keymap.set('n', '<leader>dp', function()
  vim.diagnostic.goto_prev({ float = { border = 'rounded', source = 'if_many' } })
end, { desc = 'Prev diagnostic' })

-- Diagnostics → Location List
vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, { desc = 'Diagnostics → Location List' })

-- Toggle diagnostic virtual text
vim.keymap.set('n', '<leader>dt', function()
  local cfg = vim.diagnostic.config()
  local vt = cfg.virtual_text
  local enabled = not (vt == false)
  vim.diagnostic.config({ virtual_text = not enabled })
  vim.notify('Diagnostics virtual_text: ' .. (enabled and 'OFF' or 'ON'), vim.log.levels.INFO)
end, { desc = 'Toggle virtual text' })

-- Terminal: pass Ctrl-w to Vim
vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], { desc = 'Terminal: window command passthrough', silent = true })
