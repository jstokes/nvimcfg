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
          ['<C-@>']     = cmp.mapping.complete(),
          ['<CR>'] = cmp.config.disable,
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              local entry = cmp.get_selected_entry()
              if entry then
                cmp.confirm({ select = true })
              else
                cmp.select_next_item()
              end
            elseif luasnip_ok and luasnip.expand_or_jumpable() then
              if luasnip_ok then luasnip.expand_or_jump() end
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        }),
        confirmation = {
          get_commit_characters = function() return {} end,
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'conjure' },
          { name = 'buffer' },
          { name = 'path' },
        }),
      })
    end,
  },
  {
    'PaterJason/cmp-conjure',
    ft = { 'clojure', 'fennel' },
    dependencies = { 'Olical/conjure', 'hrsh7th/nvim-cmp' },
  },
}
