# Neovim Configuration

Personal Neovim configuration using [lazy.nvim](https://github.com/folke/lazy.nvim) for plugin management. Plugins are organized into domain-specific modules under `lua/plugins/`.

## Plugins

### UI

| Plugin | Purpose |
|--------|---------|
| [nightfox.nvim](https://github.com/EdenEast/nightfox.nvim) | Colorscheme (using `carbonfox` variant) |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Statusline with branch, diff, and diagnostics info |
| [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) | Buffer tab bar with LSP diagnostics indicators |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Displays available keybindings in a popup |
| [no-neck-pain.nvim](https://github.com/shortcuts/no-neck-pain.nvim) | Centers buffer content for distraction-free editing |
| [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) | File type icons used by other plugins |
| [persistence.nvim](https://github.com/folke/persistence.nvim) | Automatic session saving and restoration |
| [snacks.nvim](https://github.com/folke/snacks.nvim) | Utility library (used by claudecode.nvim terminal provider) |

### Editing

| Plugin | Purpose |
|--------|---------|
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs) | Auto-close brackets, quotes, and parens |
| [Comment.nvim](https://github.com/numToStr/Comment.nvim) | Toggle line/block comments with `gc`/`gb` |
| [nvim-surround](https://github.com/kylechui/nvim-surround) | Add, change, and delete surrounding pairs |
| [leap.nvim](https://codeberg.org/andyg/leap.nvim) | Fast cursor motion via 2-character search |
| [vim-visual-multi](https://github.com/mg979/vim-visual-multi) | Multiple cursors |
| [mini.bufremove](https://github.com/echasnovski/mini.bufremove) | Delete buffers without closing windows |

### Treesitter

| Plugin | Purpose |
|--------|---------|
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax highlighting and code parsing (Clojure, Lua, Vim, Markdown, etc.) |
| [rainbow-delimiters.nvim](https://github.com/HiPhish/rainbow-delimiters.nvim) | Rainbow-colored matching brackets/parens |

### Telescope (Fuzzy Finder)

| Plugin | Purpose |
|--------|---------|
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder for files, buffers, grep, and more |
| [telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim) | FZF-style sorting algorithm for Telescope |
| [telescope-ui-select.nvim](https://github.com/nvim-telescope/telescope-ui-select.nvim) | Use Telescope for `vim.ui.select` prompts |
| [telescope-project.nvim](https://github.com/nvim-telescope/telescope-project.nvim) | Project switching and management |
| [telescope-file-browser.nvim](https://github.com/nvim-telescope/telescope-file-browser.nvim) | File browser extension for Telescope |

### Git

| Plugin | Purpose |
|--------|---------|
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git change indicators in the gutter/line numbers |
| [neogit](https://github.com/TimUntersberger/neogit) | Magit-style Git interface |
| [gitlinker.nvim](https://github.com/ruifm/gitlinker.nvim) | Generate shareable Git permalink URLs |
| [git-worktree.nvim](https://github.com/ThePrimeagen/git-worktree.nvim) | Git worktree management with Telescope integration |
| [octo.nvim](https://github.com/pwntester/octo.nvim) | GitHub issues and PRs inside Neovim |

### Completion (nvim-cmp)

| Plugin | Purpose |
|--------|---------|
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | Autocompletion engine |
| [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp) | LSP completion source |
| [cmp-buffer](https://github.com/hrsh7th/cmp-buffer) | Buffer words completion source |
| [cmp-path](https://github.com/hrsh7th/cmp-path) | File path completion source |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip) | Snippet engine |
| [cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip) | LuaSnip completion source for nvim-cmp |
| [cmp-conjure](https://github.com/PaterJason/cmp-conjure) | Conjure REPL completion source for Clojure/Fennel |
| [copilot-cmp](https://github.com/zbirenbaum/copilot-cmp) | GitHub Copilot completion source |

### LSP & Linting

| Plugin | Purpose |
|--------|---------|
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | Configuration for built-in LSP client |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Format-on-save using external formatters (cljstyle, stylua) |
| [ALE](https://github.com/dense-analysis/ale) | Asynchronous linting (clj-kondo for Clojure) |

### Clojure

| Plugin | Purpose |
|--------|---------|
| [conjure](https://github.com/Olical/conjure) | Interactive REPL-driven development for Clojure/Fennel |
| [nvim-paredit](https://github.com/julienvincent/nvim-paredit) | Structural editing for S-expressions (slurp, barf, raise, wrap) |

### Testing

| Plugin | Purpose |
|--------|---------|
| [neotest](https://github.com/nvim-neotest/neotest) | Test runner framework with summary panel and output viewer |
| [neotest-vim-test](https://github.com/nvim-neotest/neotest-vim-test) | vim-test adapter for neotest |
| [vim-test](https://github.com/vim-test/vim-test) | Generic test runner (configured for Leiningen/Clojure) |

### AI

| Plugin | Purpose |
|--------|---------|
| [claudecode.nvim](https://github.com/coder/claudecode.nvim) | Claude Code integration — terminal, diff review, and model selection |
| [copilot.lua](https://github.com/zbirenbaum/copilot.lua) | GitHub Copilot integration (inline suggestions disabled, used via cmp) |
| [CopilotChat.nvim](https://github.com/CopilotC-Nvim/CopilotChat.nvim) | Chat interface for GitHub Copilot |

### Multiplexer

| Plugin | Purpose |
|--------|---------|
| [multiplexer.nvim](https://github.com/stevalkr/multiplexer.nvim) | Seamless pane navigation between Neovim and tmux/zellij/kitty/wezterm |

### Markdown

| Plugin | Purpose |
|--------|---------|
| [markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim) | Live markdown preview in the browser |

## Structure

```
~/.config/nvim/
├── init.lua                    -- Entry point: leader keys, lazy.nvim bootstrap, plugin imports
├── lua/
│   ├── config/
│   │   ├── options.lua         -- Core Neovim options
│   │   ├── keymaps.lua         -- Global keybindings
│   │   └── autocmds.lua        -- Autocommands
│   └── plugins/
│       ├── ui.lua              -- Theme, statusline, bufferline, which-key
│       ├── editing.lua         -- Autopairs, comments, surround, leap, multi-cursor
│       ├── treesitter.lua      -- Treesitter + rainbow delimiters
│       ├── telescope.lua       -- Fuzzy finder + extensions
│       ├── git.lua             -- Gitsigns, neogit, gitlinker, worktrees, octo
│       ├── cmp.lua             -- Autocompletion + sources
│       ├── lsp.lua             -- LSP configuration
│       ├── conform.lua         -- Formatting
│       ├── lint.lua            -- ALE linting
│       ├── clojure.lua         -- Conjure REPL
│       ├── paredit.lua         -- Structural editing
│       ├── neotest.lua         -- Test runner
│       ├── claudecode.lua      -- Claude Code AI
│       ├── copilot.lua         -- GitHub Copilot
│       ├── copilotchat.lua     -- Copilot Chat
│       ├── multiplexer.lua     -- Terminal multiplexer nav
│       ├── markdown.lua        -- Markdown preview
│       └── no-neck-pain.lua    -- Zen mode (also referenced in ui.lua)
└── lazy-lock.json              -- Plugin version lockfile
```
