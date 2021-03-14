local lualine = require('lualine')
lualine.status()
lualine.options.theme = 'nord'
lualine.options.icons_enabled = true

-- fern
vim.api.nvim_set_var("fern#renderer", "nerdfont")
vim.api.nvim_set_var("cursorhold_updatetime", 100)
