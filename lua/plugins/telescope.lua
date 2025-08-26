return {
  { 'nvim-lua/plenary.nvim', lazy = true },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
      'nvim-telescope/telescope-project.nvim',
      'nvim-telescope/telescope-file-browser.nvim',
    },
    config = function()
      local ok, telescope = pcall(require, 'telescope')
      if not ok then return end
      telescope.setup({})
      pcall(telescope.load_extension, 'ui-select')
      pcall(telescope.load_extension, 'project')
      pcall(telescope.load_extension, 'file_browser')
    end,
  },
}
