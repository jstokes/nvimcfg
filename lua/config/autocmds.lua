-- Intentionally left empty: formatting on save handled by conform.nvim

-- Treat *.fiddle files as Clojure
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '*.fiddle',
  callback = function(args)
    -- Set filetype to clojure so Treesitter, LSP, Conjure, and cmp-conjure apply
    vim.bo[args.buf].filetype = 'clojure'
  end,
})
