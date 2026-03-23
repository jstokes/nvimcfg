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
| [flash.nvim](https://github.com/folke/flash.nvim) | Fast cursor motion with search labels and treesitter integration |
| [vim-visual-multi](https://github.com/mg979/vim-visual-multi) | Multiple cursors |
| [mini.bufremove](https://github.com/echasnovski/mini.bufremove) | Delete buffers without closing windows |

### Treesitter

| Plugin | Purpose |
|--------|---------|
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax highlighting and code parsing (Clojure, Lua, Vim, Markdown, etc.) |
| [rainbow-delimiters.nvim](https://github.com/HiPhish/rainbow-delimiters.nvim) | Rainbow-colored matching brackets/parens |

### Fuzzy Finder (fzf-lua)

| Plugin | Purpose |
|--------|---------|
| [fzf-lua](https://github.com/ibhagwan/fzf-lua) | Primary fuzzy finder using native fzf and ripgrep for files, grep, buffers, and more |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Lazy-loaded for octo.nvim and git-worktree extension compatibility |
| [telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim) | FZF-style sorting for telescope extension pickers |

### Git

| Plugin | Purpose |
|--------|---------|
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git change indicators in the gutter/line numbers |
| [neogit](https://github.com/TimUntersberger/neogit) | Magit-style Git interface with diffview integration |
| [diffview.nvim](https://github.com/sindrets/diffview.nvim) | Side-by-side diff viewer and file history browser |
| [gitlinker.nvim](https://github.com/ruifm/gitlinker.nvim) | Generate shareable Git permalink URLs |
| [git-worktree.nvim](https://github.com/ThePrimeagen/git-worktree.nvim) | Git worktree management with Telescope integration |
| [octo.nvim](https://github.com/pwntester/octo.nvim) | GitHub issues and PRs inside Neovim |

### Completion (blink.cmp)

| Plugin | Purpose |
|--------|---------|
| [blink.cmp](https://github.com/saghen/blink.cmp) | Fast autocompletion engine with ghost text (fish-style inline suggestions) and signature help |
| [blink.compat](https://github.com/saghen/blink.compat) | Compatibility layer for nvim-cmp sources (used for cmp-conjure) |
| [cmp-conjure](https://github.com/PaterJason/cmp-conjure) | Conjure REPL completion source for Clojure/Fennel |

### LSP & Linting

| Plugin | Purpose |
|--------|---------|
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | Configuration for built-in LSP client (clojure-lsp enabled) |
| [fidget.nvim](https://github.com/j-hui/fidget.nvim) | LSP progress indicator in the corner |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Format-on-save using external formatters (cljstyle, stylua) |
| [ALE](https://github.com/dense-analysis/ale) | Asynchronous linting (clj-kondo for Clojure) |
| [trouble.nvim](https://github.com/folke/trouble.nvim) | Aggregated diagnostics panel, quickfix, and LSP references viewer |

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
| [copilot.lua](https://github.com/zbirenbaum/copilot.lua) | GitHub Copilot AI completions (disabled for Clojure/Fennel to preserve REPL workflow) |
| [blink-copilot](https://github.com/fang2hou/blink-copilot) | Copilot source for blink.cmp completion menu and ghost text |

### Multiplexer

| Plugin | Purpose |
|--------|---------|
| [multiplexer.nvim](https://github.com/stevalkr/multiplexer.nvim) | Seamless pane navigation between Neovim and tmux/zellij/kitty/wezterm |

### Markdown

| Plugin | Purpose |
|--------|---------|
| [markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim) | Live markdown preview in the browser |

## Prerequisites

Install these tools for full functionality:

```sh
# Clojure LSP (go-to-definition, find references, rename, hover docs)
brew install clojure-lsp/brew/clojure-lsp-native

# Clojure linting
brew install borkdude/brew/clj-kondo

# Clojure formatting
brew install cljstyle

# fzf and ripgrep (required by fzf-lua)
brew install fzf ripgrep

# bat (optional, used for fzf-lua file preview)
brew install bat

# Lua formatting
brew install stylua
```

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
│       ├── editing.lua         -- Autopairs, comments, surround, flash, multi-cursor
│       ├── treesitter.lua      -- Treesitter + rainbow delimiters
│       ├── fzf.lua             -- fzf-lua (primary fuzzy finder) + telescope (lazy, for extensions)
│       ├── git.lua             -- Gitsigns, neogit, diffview, gitlinker, worktrees, octo
│       ├── cmp.lua             -- blink.cmp autocompletion + Conjure REPL source
│       ├── lsp.lua             -- LSP configuration (clojure-lsp) + fidget progress
│       ├── conform.lua         -- Formatting
│       ├── lint.lua            -- ALE linting
│       ├── trouble.lua         -- Diagnostics panel
│       ├── clojure.lua         -- Conjure REPL
│       ├── paredit.lua         -- Structural editing
│       ├── neotest.lua         -- Test runner
│       ├── claudecode.lua      -- Claude Code AI
│       ├── copilot.lua         -- GitHub Copilot AI completions
│       ├── multiplexer.lua     -- Terminal multiplexer nav
│       ├── markdown.lua        -- Markdown preview
│       └── no-neck-pain.lua    -- Zen mode
└── lazy-lock.json              -- Plugin version lockfile
```

## Keybinding Reference

Leader key is `<Space>`. Use `<leader>` followed by any key to see available bindings via which-key.

| Prefix | Group | Examples |
|--------|-------|---------|
| `<leader>f` | Files | `ff` find files, `fg` live grep, `fb` buffers, `fs` save |
| `<leader>b` | Buffers | `bb` list, `bd` delete, `bp` pick, `bn`/`bp` next/prev |
| `<leader>l` | LSP | `ld` definition, `lr` rename, `la` code action, `lh` hover |
| `<leader>g` | Git | `gg` neogit, `gd` diffview, `gb` blame, `gl` permalink |
| `<leader>gh` | GitHub | `ghl` PR list, `gho` PR view, `ghi` issues |
| `<leader>s` | Search | `sc` clear highlights, `sf` files in dir, `sD` grep in dir, `sp` recent files |
| `<leader>k` | Lisp/Sexp | `ks` slurp, `kb` barf, `kr` raise, `ku` splice |
| `<leader>m` | Clojure | Conjure REPL mappings |
| `<leader>t` | Toggle/Test | `tn` run nearest, `tf` run file, `ts` summary |
| `<leader>d` | Diagnostics | `de` float, `dn`/`dp` next/prev, `dt` toggle virtual text |
| `<leader>x` | Trouble | `xx` diagnostics, `xs` symbols, `xr` LSP references |
| `<leader>a` | AI (Claude) | `ac` toggle, `af` focus, `as` send selection |
| `<leader>w` | Windows | `ws` split, `wv` vsplit, `wt` terminal |
| `<leader>z` | Zen | `zn` enable, `ze` toggle, `zw`/`zW` resize |
| `<leader>q` | Session | `qs` restore, `qq` quit |

### Motion

| Key | Action |
|-----|--------|
| `s` | Flash jump (2-char search with labels) |
| `S` | Flash treesitter (jump to treesitter nodes) |
| `<C-h/j/k/l>` | Navigate panes (works across tmux/neovim) |

### Clojure REPL (Ctrl-based, Emacs-style)

| Key | Action |
|-----|--------|
| `<C-c><C-c>` | Eval root form |
| `<C-c><C-e>` | Eval current form |
| `<C-c><C-k>` | Eval file |
| `<C-c><C-z>` | Toggle REPL log |
| `<C-c><C-p>` | Pretty print form |
| `<C-c><C-;>` | Eval to comment |

### Completion

| Key | Action |
|-----|--------|
| `<Tab>` | Accept completion (fish-style ghost text via blink.cmp) |
| `<S-Tab>` | Previous completion item |
| `<C-Space>` | Trigger completion menu |
