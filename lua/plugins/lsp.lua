return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      -- clojure-lsp uses its own defaults for classpath discovery.
      -- For monorepo projects that need a custom classpath command,
      -- create a .lsp/config.edn in the project root:
      --
      --   {:project-specs
      --    [{:project-path "project.clj"
      --      :classpath-cmd ["lein" "monolith" "with-all" "classpath"]}]}
      --
      -- clojure-lsp is NOT auto-started (high memory usage).
      -- Use <leader>cl to start it on demand.
      vim.keymap.set('n', '<leader>cl', function()
        vim.lsp.enable('clojure_lsp')
        -- Attach to any already-open Clojure buffers
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          local ft = vim.bo[buf].filetype
          if ft == 'clojure' or ft == 'edn' then
            vim.lsp.buf_attach_client(buf, vim.lsp.get_clients({ name = 'clojure_lsp' })[1].id)
          end
        end
        vim.notify('clojure-lsp started', vim.log.levels.INFO)
      end, { desc = 'Start clojure-lsp' })
    end,
  },
  {
    'j-hui/fidget.nvim',
    event = 'LspAttach',
    opts = {},
  },
}
