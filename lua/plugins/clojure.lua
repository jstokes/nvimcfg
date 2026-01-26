return {
  {
    'Olical/conjure',
    ft = { 'clojure', 'fennel' },
    init = function()
      vim.g['conjure#mapping#prefix'] = '<leader>m'
      vim.g['conjure#client#clojure#nrepl#eval#pretty_print'] = true
      vim.g['conjure#completion#omnifunc'] = 'ConjureOmnifunc'
      vim.g['conjure#client#clojure#nrepl#completion#with_context'] = true
      vim.g['conjure#client#clojure#nrepl#completion#cljs#use_suitable'] = true

      -- Ensure tree-sitter extraction is enabled (required for reader macro support)
      vim.g['conjure#extract#tree_sitter#enabled'] = true

      -- Disable built-in auto_repl (we start it ourselves to avoid race conditions)
      vim.g['conjure#client#clojure#nrepl#connection#auto_repl#enabled'] = false
      vim.g['conjure#client#clojure#nrepl#connection#auto_repl#hidden'] = true
    end,
    config = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'clojure' },
        callback = function()
          vim.defer_fn(function()
            pcall(function()
              local auto = require('conjure.client.clojure.nrepl.auto-repl')
              local start = auto['upsert-auto-repl-proc'] or auto['upsert_auto_repl_proc']
              if start then start() end
            end)
          end, 200)
        end,
      })
    end,
  },
}
