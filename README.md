# Neovim Configuration

A minimal, fast Neovim configuration for **Neovim 0.12+** — lazy-loaded plugins,
native LSP (0.12 API), Treesitter highlighting, and a single transparent
Catppuccin Mocha theme.

---

## Porting to a New System

Follow these steps in order to get this config running on a fresh machine.

### 1. Prerequisites

```bash
# Core (required)
brew install neovim      # v0.12+ required
brew install git
brew install ripgrep     # used by the picker (grep)
brew install fd          # used by the picker (file find)
brew install lazygit     # git TUI (<leader>gg)
brew install node        # provides node + npm
```

### 2. Treesitter CLI — IMPORTANT

Treesitter parsers are compiled on first launch and this **requires the
`tree-sitter` CLI**. Note the gotcha:

> `brew install tree-sitter` installs only the *library*, **not** the CLI
> binary. Install the CLI from npm instead:

```bash
npm install -g tree-sitter-cli
```

Verify it is on your `PATH`:

```bash
tree-sitter --version
```

Without this, no language gets syntax colors (the config will still load, but
files render as plain text). `lua/core/lazy.lua` attempts a `cargo`-based
fallback install, but npm is the reliable path.

### 3. Nerd Font

Install a [Nerd Font](https://www.nerdfonts.com/) for icons and set your
terminal to use it:

```bash
brew install --cask font-jetbrains-mono-nerd-font
```

### 4. Clone the Config

```bash
# Back up any existing config first (optional but recommended)
mv ~/.config/nvim ~/.config/nvim.old 2>/dev/null

git clone <your-repo-url> ~/.config/nvim
```

### 5. First Launch

```bash
nvim
```

On first launch, in order:
- `lazy.nvim` bootstraps itself and installs all plugins.
- `mason` auto-installs every LSP server, linter, and formatter (see below).
- Treesitter compiles its parsers (needs the CLI from step 2).

Then **restart Neovim once** so the freshly compiled Treesitter parsers load.

### 6. Language Toolchains (install what you use)

The LSP servers and language commands need the actual compilers/runtimes:

```bash
brew install go        # Go      — :GoInstallBinaries for extra tools
brew install zig       # Zig
brew install python    # Python
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh   # Rust
```

### 7. Verify

```vim
:checkhealth
```

Expected harmless warnings: which-key keymap overlaps, `luarocks` (no plugin
needs it), optional toolchains you didn't install.

---

## What Gets Auto-Installed

### Plugins (via lazy.nvim)

Completion (`blink.cmp`), Treesitter, `snacks.nvim` (picker / explorer /
dashboard / terminal / notifications), `which-key`, `flash`, `mini.nvim`
(ai / surround / pairs / statusline), `trouble`, `gitsigns` + `diffview` +
`fugitive`, `conform` (format), `nvim-lint`, `mason`, `render-markdown`,
`markdown-preview`, `catppuccin`.

### LSP / Linters / Formatters (via Mason)

| Category | Tools |
|----------|-------|
| **LSP Servers** | lua-language-server, gopls, bash-language-server, css-lsp, html-lsp, json-lsp, pyright, rust-analyzer, typescript-language-server, yaml-language-server, zls |
| **Linters** | eslint_d, luacheck, golangci-lint, shellcheck, markdownlint, yamllint, jsonlint, htmlhint, stylelint, ruff, mypy |
| **Formatters** | stylua, goimports, prettier, black, isort, shfmt |

### Treesitter Parsers

bash, c, css, go, gomod, gosum, gowork, html, javascript, json, latex, lua,
luadoc, luap, markdown, markdown_inline, proto, python, query, regex, rust,
scss, svelte, terraform, tsx, typescript, vim, vimdoc, vue, yaml, zig

---

## Structure

```
~/.config/nvim/
├── init.lua                 # Entry point
├── lua/
│   ├── core/
│   │   ├── init.lua         # Loads all core modules
│   │   ├── options.lua      # Neovim options + filetype detection
│   │   ├── keymaps.lua      # Core keybindings
│   │   ├── autocmds.lua     # Auto commands
│   │   ├── lazy.lua         # Plugin manager bootstrap
│   │   └── utils.lua        # Utility functions
│   └── plugins/
│       ├── coding.lua       # Completion (blink.cmp), treesitter
│       ├── colorschemes.lua # Catppuccin theme
│       ├── editor.lua       # Flash, mini.nvim (incl. statusline), persistence
│       ├── formatting.lua   # Conform.nvim (format on save)
│       ├── git.lua          # Gitsigns, fugitive, diffview
│       ├── linting.lua      # nvim-lint
│       ├── lsp.lua          # Mason + LSP keymaps + diagnostic config
│       ├── snacks.lua       # Picker, explorer, notifications, terminal
│       └── ui.lua           # Which-key, trouble, markdown
├── lsp/                     # Per-server configs (native vim.lsp.config API)
│   ├── bashls.lua    cssls.lua   gopls.lua   html.lua
│   ├── jsonls.lua    lua_ls.lua  pyright.lua rust_analyzer.lua
│   └── ts_ls.lua     yamlls.lua  zls.lua
├── ftplugin/
│   ├── go.lua               # Go commands (:GoTest, :GoBuild, etc.)
│   ├── rust.lua             # Rust commands (:CargoRun, :CargoTest, etc.)
│   └── zig.lua              # Zig commands (:ZigBuild, :ZigTest, etc.)
└── doc/
    ├── go.txt               # :help go.txt
    ├── rust.txt             # :help rust.txt
    └── zig.txt              # :help zig.txt
```

LSP servers use Neovim 0.12's native `vim.lsp.config()` / `vim.lsp.enable()` —
there is no `nvim-lspconfig`.

---

## Keybindings

**Leader key:** `<Space>`

### Essential (No Prefix)

| Key | Action |
|-----|--------|
| `<C-s>` | Save file |
| `<C-h/j/k/l>` | Navigate windows |
| `<C-Up/Down/Left/Right>` | Resize windows |
| `<Esc>` | Clear search highlight |
| `jj` / `jk` | Exit insert mode |
| `H` / `L` | Start/End of line |
| `<S-h>` / `<S-l>` | Prev/Next buffer |
| `Q` | Delete buffer |
| `K` | Hover documentation |
| `s` | Flash jump |
| `S` | Flash treesitter |

### Quick Access (Leader)

| Key | Action |
|-----|--------|
| `<leader><space>` | Find files |
| `<leader>/` | Grep |
| `<leader>,` | Switch buffer |
| `<leader>.` | Scratch buffer |
| `<leader>e` | File explorer |
| `<leader>q` | Quit |
| `<leader>Q` | Quit all |
| `<leader>?` | Buffer keymaps |
| `<leader>K` | All keymaps |
| `<C-/>` | Terminal |

### Buffers (`<leader>b`)

| Key | Action |
|-----|--------|
| `<leader>bb` | Switch buffer |
| `<leader>bd` | Delete buffer |
| `<leader>bo` | Delete other buffers |

### Code (`<leader>c`)

| Key | Action |
|-----|--------|
| `<leader>ca` | Code action |
| `<leader>cr` | Rename symbol |
| `<leader>cd` | Line diagnostic |
| `<leader>cf` | Format |
| `<leader>cv` | Definition in vsplit |

### Diagnostics (`<leader>d`)

| Key | Action |
|-----|--------|
| `<leader>dd` | Workspace diagnostics |
| `<leader>db` | Buffer diagnostics |
| `<leader>dt` | Trouble (workspace) |
| `<leader>dT` | Trouble (buffer) |
| `<leader>dq` | Quickfix list |
| `<leader>dl` | Location list |

### Files (`<leader>f`)

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fr` | Recent files |
| `<leader>fc` | Config files |
| `<leader>fg` | Git files |
| `<leader>fp` | Projects |
| `<leader>fR` | Rename file |

### Git (`<leader>g`)

| Key | Action |
|-----|--------|
| `<leader>gg` | Lazygit |
| `<leader>gs` | Status |
| `<leader>gl` | Log |
| `<leader>gL` | Log (line) |
| `<leader>gf` | Log (file) |
| `<leader>gd` | Diff (picker) |
| `<leader>gD` | Diff HEAD |
| `<leader>gc` | Checkout branch |
| `<leader>go` | Open in browser |
| `<leader>gb` | Blame line |
| `<leader>gB` | Blame buffer |
| `<leader>gR` | Reset buffer |
| `<leader>gS` | Stage buffer |
| `<leader>gi` | GitHub issues |
| `<leader>gp` | GitHub PRs |

### Git Hunks (`<leader>gh`)

| Key | Action |
|-----|--------|
| `<leader>ghp` | Preview hunk |
| `<leader>ghP` | Preview hunk inline |
| `<leader>ghs` | Stage hunk |
| `<leader>ghu` | Undo stage hunk |
| `<leader>ghr` | Reset hunk |
| `]h` / `[h` | Next/Prev hunk |

### LSP (`<leader>l`)

| Key | Action |
|-----|--------|
| `<leader>ls` | Document symbols |
| `<leader>lS` | Workspace symbols |
| `<leader>li` | LSP info |
| `<leader>lr` | LSP restart |
| `<leader>lh` | Toggle inlay hints |
| `<leader>lt` | References (Trouble) |
| `<leader>lT` | Symbols (Trouble) |
| `<leader>ll` | Lint buffer |

### Markdown (`<leader>m`)

| Key | Action |
|-----|--------|
| `<leader>mp` | Preview in browser |
| `<leader>mr` | Toggle render in buffer |

### Notifications (`<leader>n`)

| Key | Action |
|-----|--------|
| `<leader>nn` | Notification history |
| `<leader>nd` | Dismiss all |

### Search (`<leader>s`)

| Key | Action |
|-----|--------|
| `<leader>sg` | Grep |
| `<leader>sw` | Word under cursor |
| `<leader>sb` | Buffer lines |
| `<leader>sB` | Grep buffers |
| `<leader>sh` | Help |
| `<leader>sm` | Marks |
| `<leader>sj` | Jumps |
| `<leader>sk` | Keymaps |
| `<leader>sc` | Commands |
| `<leader>s:` | Command history |
| `<leader>s/` | Search history |
| `<leader>sr` | Registers |
| `<leader>sR` | Resume last |
| `<leader>su` | Undo history |

### UI/Toggles (`<leader>u`)

| Key | Action |
|-----|--------|
| `<leader>us` | Toggle spelling |
| `<leader>uw` | Toggle wrap |
| `<leader>ur` | Toggle relative numbers |
| `<leader>ul` | Toggle line numbers |
| `<leader>uD` | Toggle diagnostics |
| `<leader>uc` | Toggle conceal |
| `<leader>uT` | Toggle treesitter |
| `<leader>ub` | Toggle background |
| `<leader>uh` | Toggle inlay hints |
| `<leader>ui` | Toggle indent guides |
| `<leader>ud` | Toggle dim |
| `<leader>uC` | Colorschemes |
| `<leader>uz` | Zen mode |
| `<leader>uZ` | Zoom |

### Windows (`<leader>w`)

| Key | Action |
|-----|--------|
| `<leader>wd` | Close window |
| `<leader>ws` | Split horizontal |
| `<leader>wv` | Split vertical |
| `<leader>ww` | Other window |
| `<leader>w=` | Equal size |
| `<leader>wm` | Maximize |

### Goto (`g`)

| Key | Action |
|-----|--------|
| `gd` | Definition |
| `gD` | Declaration |
| `gr` | References |
| `gi` | Implementation |
| `gy` | Type definition |

### Navigation (`[` / `]`)

| Key | Action |
|-----|--------|
| `[d` / `]d` | Prev/Next diagnostic |
| `[h` / `]h` | Prev/Next hunk |
| `[b` / `]b` | Prev/Next buffer |
| `[[` / `]]` | Prev/Next reference |

### Editing

| Key | Mode | Action |
|-----|------|--------|
| `J` / `K` | Visual | Move lines down/up |
| `<` / `>` | Visual | Indent (stay selected) |
| `p` | Visual | Paste (no yank) |
| `X` | Normal | Split line |
| `YY` | Normal | Yank block {} |
| `n` / `N` | Normal | Next/Prev match (centered) |

### Surround (mini.surround)

| Key | Action |
|-----|--------|
| `gsa` | Add surrounding |
| `gsd` | Delete surrounding |
| `gsr` | Replace surrounding |
| `gsf` | Find surrounding (right) |
| `gsF` | Find surrounding (left) |

---

## Language-Specific Commands

### Go (`:help go.txt`)

| Command | Action |
|---------|--------|
| `:GoBuild` | go build |
| `:GoRun` | go run |
| `:GoTest` | go test |
| `:GoTestFunc` | Test function under cursor |
| `:GoTestFile` | Test current package |
| `:GoCoverage` | Test with coverage |
| `:GoModTidy` | go mod tidy |
| `:GoGet <pkg>` | go get |
| `:GoVet` | go vet |
| `:GoLint` | golangci-lint |
| `:GoDoc <sym>` | go doc |
| `:GoImpl` | Generate interface stubs |
| `:GoIfErr` | Insert if err != nil |
| `:GoAddTags` | Add struct tags |
| `:GoAlt` | Switch test/source |
| `:GoInstallBinaries` | Install all Go tools |

### Rust (`:help rust.txt`)

| Command | Action |
|---------|--------|
| `:CargoBuild` | cargo build |
| `:CargoBuildRelease` | cargo build --release |
| `:CargoRun` | cargo run |
| `:CargoTest` | cargo test |
| `:CargoTestFunc` | Test function under cursor |
| `:CargoCheck` | cargo check |
| `:CargoClippy` | cargo clippy |
| `:CargoFmt` | cargo fmt |
| `:CargoAdd <crate>` | cargo add |
| `:CargoDoc` | cargo doc |
| `:RustDoc <crate>` | Open docs.rs |
| `:CargoInstallTools` | Install cargo subcommands |

### Zig (`:help zig.txt`)

| Command | Action |
|---------|--------|
| `:ZigBuild` | zig build |
| `:ZigBuildRelease` | zig build -Doptimize=ReleaseFast |
| `:ZigRun` | zig build run |
| `:ZigRunFile` | zig run <current file> |
| `:ZigTest` | zig build test |
| `:ZigTestFile` | zig test <current file> |
| `:ZigFmt` | zig fmt |
| `:ZigDoc` | Open Zig docs |
| `:ZigAlt` | Switch test/source |

---

## Language Servers

Server configs live under `lsp/` and are activated via `vim.lsp.enable()` in
`lua/plugins/lsp.lua` using Neovim's native 0.12 LSP API. All are auto-installed
by Mason:

| Language | Server |
|----------|--------|
| Lua | lua_ls |
| Go | gopls |
| Rust | rust_analyzer |
| Zig | zls |
| TypeScript/JavaScript | ts_ls |
| Python | pyright |
| Bash | bashls |
| CSS / HTML / JSON / YAML | vscode servers |

## Formatters (Conform)

| Language | Formatter |
|----------|-----------|
| Go | goimports, gofmt |
| Rust | rustfmt |
| Lua | stylua |
| JS/TS/JSON/YAML/HTML/CSS | prettier |
| Python | isort, black |
| Shell | shfmt |

Format on save is **enabled by default**.

## Linters (nvim-lint)

| Language | Linter |
|----------|--------|
| Go | golangci-lint |
| JS/TS | eslint_d |
| Lua | luacheck |
| Python | ruff, mypy |
| Shell | shellcheck |
| CSS/SCSS | stylelint |
| HTML | htmlhint |
| YAML / JSON / Markdown | yamllint / jsonlint / markdownlint |

---

## Colorscheme

**Catppuccin Mocha** with a transparent background — the only theme installed.

Because the background is transparent, the editor uses your terminal's
background. Syntax colors come from Catppuccin + Treesitter. If a file shows no
colors, the Treesitter parser/queries for that language are missing — see
step 2 of the setup (the `tree-sitter` CLI).

To use Catppuccin's own (non-transparent) dark background, set
`transparent_background = false` in `lua/plugins/colorschemes.lua`.

---

## Troubleshooting

```vim
:checkhealth          " full diagnostic report
:Lazy                 " plugin status / sync / clean
:Mason                " LSP / linter / formatter installs
:checkhealth vim.lsp  " LSP status
```

| Symptom | Fix |
|---------|-----|
| Files have no syntax colors | Install the `tree-sitter` CLI (`npm install -g tree-sitter-cli`), restart |
| `tree-sitter build` errors on startup | Same as above — the CLI is missing |
| LSP not attaching | `:Mason` — confirm the server installed; `:checkhealth vim.lsp` |
| Missing CLI tool | `brew install <tool>` |

---

Always a WIP.
