# Neovim Config

Personal Neovim configuration. Minimal, efficient, portable. Built for Go and Python development.

## What's Included

- **Plugin manager:** [lazy.nvim](https://github.com/folke/lazy.nvim)
- **Colorscheme:** [catppuccin](https://github.com/catppuccin/nvim) (mocha flavour)
- **UI:** [bufferline](https://github.com/akinsho/bufferline.nvim), [lualine](https://github.com/nvim-lualine/lualine.nvim)
- **LSP:** [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) + [mason](https://github.com/mason-org/mason.nvim)
- **Syntax:** [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- **Completion:** [blink.cmp](https://github.com/Saghen/blink.cmp)
- **Formatting:** [conform.nvim](https://github.com/stevearc/conform.nvim)
- **Fuzzy finder:** [fzf-lua](https://github.com/ibhagwan/fzf-lua)
- **File explorer:** [neo-tree](https://github.com/nvim-neo-tree/neo-tree.nvim)
- **Git:** [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
- **Diagnostics panel:** [trouble.nvim](https://github.com/folke/trouble.nvim)
- **TODO comments:** [todo-comments.nvim](https://github.com/folke/todo-comments.nvim)

---

## Setup on a Fresh Mac

Assumes you only have the Neovim binary installed. Run these in order.

### 1. Install system dependencies via Homebrew

If you don't have Homebrew yet:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Then install everything:

```bash
# Xcode Command Line Tools (for the C compiler that treesitter parsers need)
xcode-select --install

# Core tools used by the config
brew install git ripgrep fd

# Languages
brew install go python

# A Nerd Font (required for icons in bufferline, lualine, neo-tree, etc.)
brew install --cask font-jetbrains-mono-nerd-font
```

After installing the Nerd Font, set your terminal (iTerm2, Ghostty, Wezterm, Terminal.app, etc.) to use **JetBrainsMono Nerd Font**. Otherwise icons render as tofu boxes (□).

### 2. Clone this repo into Neovim's config directory

```bash
git clone <this-repo-url> ~/.config/nvim
```

If `~/.config/nvim` already exists with another config, back it up first:

```bash
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak    # plugin data
mv ~/.local/state/nvim ~/.local/state/nvim.bak    # state/cache
```

### 3. First launch

```bash
nvim
```

What happens automatically:

1. `lazy.nvim` clones itself
2. All plugins install
3. `mason` installs LSP servers (`pyright`, `gopls`, `lua-language-server`) and formatters (`black`, `isort`, `gofumpt`, `goimports`, `stylua`)
4. `treesitter` downloads and compiles parsers

You'll see progress windows. **Wait for it all to finish**, then quit (`:qa`) and **relaunch once** so treesitter parsers fully take effect.

### 4. Verify the install

Inside Neovim:

```vim
:checkhealth
```

Scroll through. Anything in red is broken; yellow warnings are usually fine. Common things to verify:

- `lazy` reports all plugins loaded
- `mason` finds all the tools you'd expect
- `treesitter` shows parsers as installed
- `vim.lsp` is healthy

To test that LSP works, open a Go or Python file and:

- Type some code → completion should pop up
- Hover over an identifier and press `K` → docs should appear
- Press `gd` on a symbol → should jump to definition

---

## Updating

```vim
:Lazy sync       " update plugins
:Mason           " UI for managing LSP servers / formatters; press U to update all
:TSUpdate        " update treesitter parsers
```

After pulling new changes from this repo, also run `:Lazy sync` so plugin specs get re-resolved.

---

## Directory Layout

```
~/.config/nvim/
├── init.lua                    -- entry point
├── lua/
│   ├── config/
│   │   ├── options.lua         -- vim.opt settings (line numbers, indent, etc.)
│   │   ├── keymaps.lua         -- non-plugin keybindings
│   │   ├── autocmds.lua        -- autocommands (yank highlight, trim whitespace, etc.)
│   │   └── lazy.lua            -- bootstraps lazy.nvim
│   └── plugins/
│       ├── colorscheme.lua     -- catppuccin
│       ├── ui.lua              -- bufferline, lualine, devicons
│       ├── editor.lua          -- fzf-lua, neo-tree, todo, trouble, gitsigns
│       ├── treesitter.lua
│       ├── lsp.lua             -- mason + nvim-lspconfig
│       ├── completion.lua      -- blink.cmp
│       └── formatting.lua      -- conform
└── README.md
```

To add a plugin, drop a new file in `lua/plugins/`. To disable one, delete or rename it.

---

## Keybinding Cheatsheet

**Leader key is `<Space>`.** Notation: `<C-x>` = Ctrl+x, `<S-x>` = Shift+x, `<leader>` = Space.

### Find / Navigate (fzf-lua)

| Keys | Action |
|---|---|
| `<leader><space>` | Find files |
| `<leader>ff` | Find files |
| `<leader>fg` or `<leader>/` | Grep across project |
| `<leader>fb` | Switch buffer |
| `<leader>fr` | Recent files |
| `<leader>fh` | Search help docs |
| `<leader>fk` | Search keymaps |
| `<leader>fc` | Search commands |
| `<leader>fd` | Search workspace diagnostics |
| `<leader>fs` | Document symbols (current file) |
| `<leader>fS` | Workspace symbols |
| `<leader>ft` | Find TODO/FIXME comments |

### File Explorer (neo-tree)

| Keys | Action |
|---|---|
| `<leader>e` | Toggle file explorer |
| `<leader>E` | Open explorer at current file |

Inside neo-tree: `a` add, `d` delete, `r` rename, `c` copy, `x` cut, `p` paste, `?` show all mappings.

### Buffers

| Keys | Action |
|---|---|
| `<S-l>` / `<S-h>` | Next / previous buffer |
| `]b` / `[b` | Next / previous buffer (alternate) |
| `<leader>bd` | Delete buffer |
| `<leader>bp` | Pin buffer |
| `<leader>bP` | Delete all non-pinned buffers |

### Windows / Splits

| Keys | Action |
|---|---|
| `<leader>|` | Split vertically |
| `<leader>-` | Split horizontally |
| `<C-h/j/k/l>` | Move between splits |
| `<C-Up/Down/Left/Right>` | Resize current split |

### LSP (only active when an LSP attaches)

| Keys | Action |
|---|---|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | Find references |
| `gi` | Go to implementation |
| `gy` | Go to type definition |
| `K` | Show hover docs |
| `<leader>ca` | Code action |
| `<leader>cr` | Rename symbol |
| `<leader>cd` | Show line diagnostics in float |
| `<leader>cs` | Signature help |
| `<leader>cf` | Format buffer (or selection in visual) |
| `]d` / `[d` | Next / previous diagnostic |

### Completion (blink.cmp, in insert mode)

| Keys | Action |
|---|---|
| `<C-space>` | Trigger completion menu |
| `<C-n>` / `<C-p>` | Next / previous item |
| `<C-y>` | Accept completion |
| `<C-e>` | Dismiss menu |
| `<Tab>` / `<S-Tab>` | Jump between snippet placeholders |

### Diagnostics & Trouble Panel

| Keys | Action |
|---|---|
| `<leader>xx` | Diagnostics panel (workspace) |
| `<leader>xX` | Diagnostics panel (current buffer) |
| `<leader>xs` | Symbols panel |
| `<leader>xl` | LSP refs/defs/impls panel |
| `<leader>xL` | Location list |
| `<leader>xQ` | Quickfix list |
| `<leader>xt` | TODO comments panel |

### Git (gitsigns, active in any file inside a git repo)

| Keys | Action |
|---|---|
| `]h` / `[h` | Next / previous hunk |
| `<leader>ghs` | Stage hunk (works in visual too) |
| `<leader>ghr` | Reset hunk |
| `<leader>ghp` | Preview hunk |
| `<leader>ghb` | Blame current line |
| `<leader>ghd` | Diff this file against index |

### TODO Comments

| Keys | Action |
|---|---|
| `]t` / `[t` | Next / previous TODO |
| `<leader>ft` | Find TODOs (fuzzy) |
| `<leader>xt` | TODOs in Trouble panel |

### Treesitter

| Keys | Action |
|---|---|
| `<C-space>` (normal mode) | Start incremental selection at cursor |
| `<C-space>` (visual mode) | Expand selection to parent node |
| `<BS>` (visual mode) | Shrink selection |

### General Editing

| Keys | Action |
|---|---|
| `<C-s>` | Save file (works in normal, insert, visual) |
| `<Esc>` | Clear search highlights |
| `<leader>qq` | Quit all |
| `<C-d>` / `<C-u>` | Half-page down/up, centered |
| `n` / `N` | Next/prev search result, centered |
| `J` / `K` in visual | Move selected lines down/up |
| `<` / `>` in visual | Indent left/right (keeps selection) |

---

## Adding More Languages

When you want to add a language (say, TypeScript), three places need updates:

1. **`lua/plugins/treesitter.lua`** — add the parser names to `ensure_installed`:
   ```lua
   "javascript", "typescript", "tsx",
   ```

2. **`lua/plugins/lsp.lua`** — add to mason's `ensure_installed` list and add a server entry:
   ```lua
   -- in mason opts.ensure_installed:
   "typescript-language-server",
   -- in lspconfig servers table:
   ts_ls = {},
   ```

3. **`lua/plugins/formatting.lua`** — add the formatter:
   ```lua
   -- in mason opts.ensure_installed (lsp.lua):
   "prettierd",
   -- in conform formatters_by_ft:
   typescript = { "prettierd" },
   javascript = { "prettierd" },
   ```

Restart Neovim and the tools auto-install.

---

## Troubleshooting

**Icons render as boxes/question marks.** Your terminal isn't using a Nerd Font. Install one with `brew install --cask font-jetbrains-mono-nerd-font` and set your terminal font to "JetBrainsMono Nerd Font".

**Treesitter highlighting looks broken.** Run `:TSUpdate` and restart.

**LSP doesn't work in a file.** Check `:LspInfo` to see which server is attached. Then `:Mason` to verify the server is installed. If not, install it from the Mason UI (`i` on the package).

**`gopls` complains about workspace.** It expects a `go.mod` file. Run `go mod init <module-name>` in your project root.

**Formatter not running on save.** Run `:ConformInfo` to see what conform thinks for the current buffer. The formatter binary needs to be available — usually mason installs it, but you can verify by running it from your shell.

**Want to know what a keymap does?** `<leader>fk` to fuzzy-search every keymap, or `:Telescope keymaps` equivalent.

**Plugin update broke something.** `:Lazy` opens the manager; press `R` on a plugin to restore it to a working version.
