-- Set leader BEFORE lazy.nvim loads, so plugin keymaps see it
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Load core config
require("config.options")
require("config.lazy") -- bootstraps and loads plugins from lua/plugins/
require("config.keymaps")
require("config.autocmds")
