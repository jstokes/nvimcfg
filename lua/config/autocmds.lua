-- Autocommands and UI integration

-- Formatting on save handled by conform.nvim

-- Filetype: recognize *.fiddle as Clojure
vim.filetype.add({
  extension = { fiddle = 'clojure' },
})

-- Automatically reload files changed externally (e.g. by AI CLI tools)
vim.o.autoread = true
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold' }, {
  pattern = '*',
  command = 'silent! checktime',
})

