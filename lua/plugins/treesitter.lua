return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master", -- stable branch
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSUpdate", "TSInstall", "TSInstallInfo" },
    opts = {
      ensure_installed = {
        -- For editing this config and reading help docs
        "lua",
        "luadoc",
        "vim",
        "vimdoc",
        -- Your languages
        "python",
        "go",
        "gomod",
        "gosum",
        "gowork",
        -- Common config formats
        "json",
        "yaml",
        "toml",
        "markdown",
        "markdown_inline",
        "bash",
        "gitcommit",
        "gitignore",
        "diff",
        "regex",
      },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
