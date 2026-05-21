return {
  {
    "saghen/blink.cmp",
    event = "InsertEnter",
    version = "*", -- use latest stable release (blink ships precompiled binaries)
    opts = {
      keymap = { preset = "default" },
      -- default preset:
      --   <C-space> = open menu / complete
      --   <C-n>/<C-p> or <Up>/<Down> = navigate
      --   <C-y> = accept
      --   <C-e> = cancel
      --   <Tab>/<S-Tab> = snippet jump
      appearance = { nerd_font_variant = "mono" },
      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 200 },
        ghost_text = { enabled = true }, -- shows the suggestion inline (greyed out)
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      signature = { enabled = true }, -- function signature help while typing
    },
  },
}
