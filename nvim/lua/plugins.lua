local lualine = require('lualine')
lualine.status()
lualine.options.theme = 'nord'
lualine.options.icons_enabled = true

-- fern.vim
vim.api.nvim_set_var("fern#renderer", "nerdfont")
vim.api.nvim_set_var("cursorhold_updatetime", 100)

-- vim-startify
vim.api.nvim_set_var("startify_bookmarks", {"~/.config/nvim/init.vim"})

-- telescope.vim
vim.api.nvim_set_keymap('n', '<leader>ff','<cmd>Telescope find_files<cr>', { silent=true, noremap=true })
vim.api.nvim_set_keymap('n', '<leader>fg','<cmd>Telescope live_grep<cr>', { silent=true, noremap=true })
