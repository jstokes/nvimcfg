return {
  {
    'Olical/conjure',
    ft = { 'clojure', 'fennel' },
    init = function()
      -- Configure Conjure before it loads
      vim.g['conjure#mapping#prefix'] = '<leader>m'
      vim.g['conjure#client#clojure#nrepl#eval#pretty_print'] = true
      vim.g['conjure#completion#omnifunc'] = 'ConjureOmnifunc'

      -- Workaround: defer auto-repl to avoid race with buffer/window during startup
      -- Disable built-in auto_repl (we'll start it ourselves on FileType)
      vim.g['conjure#client#clojure#nrepl#connection#auto_repl#enabled'] = false
      vim.g['conjure#client#clojure#nrepl#connection#auto_repl#hidden'] = true
    end,
    config = function()
      -- Defer starting the auto-repl slightly after the Clojure buffer is ready
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'clojure' },
        callback = function()
          -- Small delay to ensure buffers/windows are stable
          vim.defer_fn(function()
            pcall(function()
              local auto = require('conjure.client.clojure.nrepl.auto-repl')
              local start = auto["upsert-auto-repl-proc"] or auto["upsert_auto_repl_proc"]
              if start then start() end
            end)
          end, 200)
        end,
      })
    end,
  },
}
