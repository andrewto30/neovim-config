local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true -- hybrid line numbers (current line absolute, others relative)

-- Indentation
opt.expandtab = true -- tabs become spaces
opt.shiftwidth = 2 -- 2-space indents (Go uses tabs, handled by ftplugin/autocmd below)
opt.tabstop = 2
opt.smartindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true -- case-sensitive only when uppercase letters present
opt.hlsearch = true -- highlight matches

-- UI
opt.termguicolors = true -- 24-bit color
opt.signcolumn = "yes" -- always show sign column (no jitter when diagnostics appear)
opt.cursorline = true -- highlight current line
opt.scrolloff = 8 -- keep 8 lines visible above/below cursor
opt.sidescrolloff = 8
opt.wrap = false -- don't wrap long lines
opt.splitright = true -- vertical splits open to the right
opt.splitbelow = true -- horizontal splits open below

-- Behavior
opt.mouse = "a" -- enable mouse in all modes
opt.clipboard = "unnamedplus" -- system clipboard integration
opt.undofile = true -- persistent undo across sessions
opt.updatetime = 250 -- faster CursorHold (used by gitsigns, LSP)
opt.timeoutlen = 300 -- faster key sequence completion
opt.confirm = true -- ask to save instead of erroring on :q with unsaved changes

-- Completion
opt.completeopt = "menu,menuone,noselect"

-- Folding (treesitter-based; folds open by default)
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99
