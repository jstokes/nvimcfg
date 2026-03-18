return {
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    },
    event = 'InsertEnter',
    config = function()
      local ok_cmp, cmp = pcall(require, 'cmp')
      if not ok_cmp then
        return
      end
      local luasnip_ok, luasnip = pcall(require, 'luasnip')
      if luasnip_ok then
        require('luasnip.loaders.from_vscode').lazy_load()
      end
       cmp.setup {
         snippet = {
           expand = function(args)
             if luasnip_ok then
               luasnip.lsp_expand(args.body)
             end
           end,
         },
         mapping = cmp.mapping.preset.insert {
           ['<C-Space>'] = cmp.mapping.complete(),
           ['<C-@>'] = cmp.mapping.complete(),
           ['<CR>'] = cmp.config.disable,
           ['<Tab>'] = cmp.mapping(function(fallback)
             if cmp.visible() then
               local entry = cmp.get_selected_entry()
               if entry then
                 cmp.confirm { select = true }
               else
                 cmp.select_next_item()
               end
             elseif luasnip_ok and luasnip.expand_or_jumpable() then
               if luasnip_ok then
                 luasnip.expand_or_jump()
               end
             else
               fallback()
             end
           end, { 'i', 's' }),
           ['<S-Tab>'] = cmp.mapping.select_prev_item(),
         },
         confirmation = {
           get_commit_characters = function()
             return {}
           end,
         },
         -- Default sources: keep general priorities for non-Clojure buffers
         sources = cmp.config.sources {
            { name = 'nvim_lsp' },
            { name = 'buffer' },
            { name = 'path' },
         },
 
         -- For Clojure buffers, prefer REPL (Conjure) completions when connected,
         -- and fall back to LSP/buffer/path when not connected. Using groups makes
         -- cmp try the first group, and if it returns no items, it tries the next.
         -- This gives you REPL-powered autocompletion whenever available.
         -- Note: cmp-conjure returns no items if not connected, so fallback works.
       }

      -- Filetype-specific setup for Clojure
       cmp.setup.filetype('clojure', {
         sources = cmp.config.sources(
           { { name = 'conjure' } },
           { { name = 'nvim_lsp' }, { name = 'buffer' }, { name = 'path' } }
         ),
       })

      -- Optional: also enable for Fennel via Conjure
       cmp.setup.filetype('fennel', {
         sources = cmp.config.sources(
           { { name = 'conjure' } },
           { { name = 'nvim_lsp' }, { name = 'buffer' }, { name = 'path' } }
         ),
       })
    end,
  },
  {
    'PaterJason/cmp-conjure',
    ft = { 'clojure', 'fennel' },
    dependencies = { 'Olical/conjure', 'hrsh7th/nvim-cmp' },
  },
}
