return {
  -- Fuzzy finder (files, grep, buffers, LSP symbols, etc.)
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    dependencies = "nvim-tree/nvim-web-devicons",
    keys = {
      { "<leader><space>", "<cmd>FzfLua files<cr>", desc = "Find files" },
      { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>FzfLua live_grep<cr>", desc = "Grep" },
      { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Buffers" },
      { "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent files" },
      { "<leader>fh", "<cmd>FzfLua help_tags<cr>", desc = "Help" },
      { "<leader>fk", "<cmd>FzfLua keymaps<cr>", desc = "Keymaps" },
      { "<leader>fc", "<cmd>FzfLua commands<cr>", desc = "Commands" },
      { "<leader>fd", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Diagnostics" },
      { "<leader>fs", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "Symbols (file)" },
      { "<leader>fS", "<cmd>FzfLua lsp_workspace_symbols<cr>", desc = "Symbols (workspace)" },
      { "<leader>/", "<cmd>FzfLua live_grep<cr>", desc = "Grep" },
    },
    opts = {
      winopts = { height = 0.85, width = 0.85, preview = { layout = "vertical" } },
    },
  },

  -- File explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Explorer" },
      { "<leader>E", "<cmd>Neotree reveal<cr>", desc = "Explorer (reveal file)" },
    },
    opts = {
      filesystem = {
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true, -- auto-refresh on filesystem changes
        filtered_items = {
          visible = false,
          hide_dotfiles = false, -- show hidden files by default
          hide_gitignored = true,
        },
      },
      window = {
        width = 35,
        mappings = {
          ["<space>"] = "none", -- don't steal our leader
        },
      },
    },
  },

  -- TODO/FIXME/HACK/NOTE highlighting and navigation
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = "nvim-lua/plenary.nvim",
    keys = {
      {
        "]t",
        function()
          require("todo-comments").jump_next()
        end,
        desc = "Next todo",
      },
      {
        "[t",
        function()
          require("todo-comments").jump_prev()
        end,
        desc = "Prev todo",
      },
      { "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
      { "<leader>ft", "<cmd>TodoFzfLua<cr>", desc = "Todo (find)" },
    },
    opts = {},
  },

  -- Better diagnostics/quickfix/references panel
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {},
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer diagnostics" },
      { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
      {
        "<leader>xl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP refs/defs/impls",
      },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location list" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix list" },
    },
  },

  -- Git markers in sign column and inline hunk actions
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns
        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end
        map("n", "]h", gs.next_hunk, "Next hunk")
        map("n", "[h", gs.prev_hunk, "Prev hunk")
        map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<cr>", "Stage hunk")
        map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<cr>", "Reset hunk")
        map("n", "<leader>ghp", gs.preview_hunk, "Preview hunk")
        map("n", "<leader>ghb", function()
          gs.blame_line({ full = true })
        end, "Blame line")
        map("n", "<leader>ghd", gs.diffthis, "Diff this")
      end,
    },
  },
}
