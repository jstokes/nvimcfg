return {
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    },
    config = function()
      local ok_cmp, cmp = pcall(require, 'cmp')
      if not ok_cmp then return end
      local luasnip_ok, luasnip = pcall(require, 'luasnip')
      if luasnip_ok then
        require('luasnip.loaders.from_vscode').lazy_load()
      end
      cmp.setup({
        snippet = {
          expand = function(args)
            if luasnip_ok then luasnip.lsp_expand(args.body) end
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        }),
        sources = cmp.config.sources({
          { name = 'buffer' },
          { name = 'path' },
          { name = 'nvim_lsp' },
        }),
      })
    end,
  },
}
