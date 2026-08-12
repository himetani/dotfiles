vim.api.nvim_create_autocmd("FileType", {
  pattern = "sql",
  callback = function()
    -- Set the number of spaces used for each indentation level
    vim.opt_local.shiftwidth = 4 -- adjust this number as needed
    vim.opt_local.tabstop = 4 -- adjust this as well
    vim.opt_local.expandtab = true -- use spaces instead of tabs (optional)
  end,
})
