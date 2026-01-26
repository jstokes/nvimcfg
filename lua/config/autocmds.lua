-- Autocommands and UI integration

-- Formatting on save handled by conform.nvim

-- Filetype: recognize *.fiddle as Clojure
vim.filetype.add({
  extension = { fiddle = 'clojure' },
})
