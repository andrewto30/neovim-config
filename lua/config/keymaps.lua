local map = vim.keymap.set

-- Clear search highlights
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlights" })

-- Better window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })

-- Window splits
map("n", "<leader>|", "<cmd>vsplit<cr>", { desc = "Split vertical" })
map("n", "<leader>-", "<cmd>split<cr>", { desc = "Split horizontal" })

-- Resize windows
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Resize up" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Resize down" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Resize left" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Resize right" })

-- Buffer navigation
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })

-- Save
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr><Esc>", { desc = "Save file" })

-- Quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-- Keep cursor centered when scrolling/searching
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Move lines up/down in visual mode
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Stay in indent mode when shifting
map("v", "<", "<gv")
map("v", ">", ">gv")
