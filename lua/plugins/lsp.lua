return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      -- Optional: add a formatter/linter manager if you like (mason omitted per lean setup)
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      local ok_lsp, lspconfig = pcall(require, 'lspconfig')
      if not ok_lsp then return end

      -- Enhanced capabilities for completion provider (Blink preferred, fallback to nvim-cmp)
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok_blink, blink = pcall(require, 'blink.cmp')
      if ok_blink and blink and blink.get_lsp_capabilities then
        capabilities = vim.tbl_deep_extend('force', capabilities, blink.get_lsp_capabilities())
      else
        local ok_cmp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
        if ok_cmp and cmp_nvim_lsp and cmp_nvim_lsp.default_capabilities then
          capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
        end
      end

      -- Global on_attach to set reasonable keymaps once per buffer
      local on_attach = function(_, bufnr)
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
        end
        map('n', 'gd', vim.lsp.buf.definition, 'LSP: Go to Definition')
        map('n', 'gr', vim.lsp.buf.references, 'LSP: References')
        map('n', 'K', vim.lsp.buf.hover, 'LSP: Hover')
        map('n', '<leader>rn', vim.lsp.buf.rename, 'LSP: Rename')
        map('n', '<leader>ca', vim.lsp.buf.code_action, 'LSP: Code Action')
        map('n', 'gI', vim.lsp.buf.implementation, 'LSP: Implementation')
        map('n', '<leader>f', function()
          if vim.lsp.buf.format then
            vim.lsp.buf.format({ async = true })
          end
        end, 'LSP: Format')
      end

      -- Clojure using monolith-lsp
      if vim.fn.executable('monolith-lsp') == 1 then
        local configs = require('lspconfig.configs')
        if not configs.clojure_monolith then
          configs.clojure_monolith = {
            default_config = {
              cmd = { 'monolith-lsp' },
              filetypes = { 'clojure', 'clojurescript', 'clojurec', 'edn' },
              root_dir = function(fname)
                -- Look for common Clojure project markers
                local util = require('lspconfig.util')
                return util.root_pattern('project.clj', 'deps.edn', 'bb.edn', 'shadow-cljs.edn', 'build.boot', '.git')(fname)
                  or util.path.dirname(fname)
              end,
              single_file_support = true,
            },
          }
        end
        lspconfig.clojure_monolith.setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end

      -- You can add more servers here as needed, e.g. lua_ls, tsserver, etc.
    end,
  },
}
