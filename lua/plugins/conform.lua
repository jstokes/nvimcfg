return {
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        clojure = { 'cljstyle' },
        lua = { 'stylua' },
      },
      format_on_save = {
	lsp_fallback = false,
	timeout_ms = 500,
      }
    },
  },
}
