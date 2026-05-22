-- Colorschemes: Theme configuration
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000, -- load before other plugins so highlights are ready
    lazy = false,
    opts = {
      flavour = "mocha", -- latte (light), frappe, macchiato, mocha (darkest)
      transparent_background = true,
      integrations = {
        blink_cmp = true,
        gitsigns = true,
        treesitter = true,
        mason = true,
        native_lsp = { enabled = true },
        snacks = true,
        which_key = true,
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
