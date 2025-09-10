-- stylua: ignore

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
      local actions = require('telescope.actions')
      telescope.setup({
        defaults = {
          mappings = {
            i = {
              ["<C-d>"] = actions.delete_buffer,
            },
            n = {
              ["d"] = actions.delete_buffer,
            },
          },
          path_display = { "filename_first" }
        },
        pickers = {
          buffers = {
            sort_lastused = true,
            ignore_current_buffer = true,
            show_all_buffers = true,
            theme = 'dropdown',
            previewer = false,
            mappings = {
              i = { ["<C-d>"] = actions.delete_buffer },
              n = { ["d"] = actions.delete_buffer },
            },
          },
        },
      })
      pcall(telescope.load_extension, 'ui-select')
      pcall(telescope.load_extension, 'project')
      pcall(telescope.load_extension, 'file_browser')
    end,
  },
}
