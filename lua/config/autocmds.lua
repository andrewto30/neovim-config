local autocmd = vim.api.nvim_create_autocmd

-- Highlight yanked text briefly
autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})

-- Remove trailing whitespace on save (safety net for filetypes without a formatter)
autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    if not vim.b.disable_trim_whitespace then
      local save = vim.fn.winsaveview()
      vim.cmd([[%s/\s\+$//e]])
      vim.fn.winrestview(save)
    end
  end,
})

-- Auto-resize splits when terminal is resized
autocmd("VimResized", {
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- Return to last edit position when opening files
autocmd("BufReadPost", {
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      vim.cmd('normal! g`"zz')
    end
  end,
})

-- Go uses tabs, not spaces (idiomatic)
autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.bo.expandtab = false
    vim.bo.shiftwidth = 4
    vim.bo.tabstop = 4
  end,
})

-- Python: PEP 8 uses 4-space indents
autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.bo.shiftwidth = 4
    vim.bo.tabstop = 4
  end,
})
