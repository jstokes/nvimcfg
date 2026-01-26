return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      -- New nvim-treesitter API - parsers must be installed explicitly
      local ensure_installed = {
        'clojure', 'fennel', 'scheme',
        'lua', 'vim', 'vimdoc', 'query',
        'markdown', 'markdown_inline'
      }

      -- Install missing parsers on startup
      local installed = require('nvim-treesitter').get_installed()
      local to_install = vim.tbl_filter(function(lang)
        return not vim.tbl_contains(installed, lang)
      end, ensure_installed)

      if #to_install > 0 then
        require('nvim-treesitter').install(to_install)
      end

      -- Enable treesitter highlighting for supported filetypes
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
        end,
      })

      -- Start treesitter for current buffer (in case FileType already fired)
      pcall(vim.treesitter.start)
    end,
  },
  { 'HiPhish/rainbow-delimiters.nvim' },
}
