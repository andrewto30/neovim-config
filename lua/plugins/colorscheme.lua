return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000, -- load before other plugins so highlights are ready
    lazy = false,
    opts = {
      flavour = "mocha", -- latte (light), frappe, macchiato, mocha (darkest)
      integrations = {
        blink_cmp = true,
        gitsigns = true,
        neotree = true,
        treesitter = true,
        mason = true,
        native_lsp = { enabled = true },
        which_key = false,
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
