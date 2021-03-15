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
vim.api.nvim_set_keymap('n', '<leader>ll','<cmd>Telescope find_files<cr>', { silent=true, noremap=true })
vim.api.nvim_set_keymap('n', '<leader>f','<cmd>Telescope live_grep<cr>', { silent=true, noremap=true })
vim.api.nvim_set_keymap('n', 'gst','<cmd>Telescope git_status<cr>', { silent=true, noremap=true })
vim.api.nvim_set_keymap('n', 'gbranch','<cmd>Telescope git_branches<cr>', { silent=true, noremap=true })

-- vim-fugitive
vim.api.nvim_set_keymap('n', 'gdiff','<cmd>Gdiffsplit<cr>', { silent=true, noremap=true })
vim.api.nvim_set_keymap('n', 'gadd','<cmd>Gwrite<cr>', { silent=true, noremap=true })
vim.api.nvim_set_keymap('n', 'gcommit','<cmd>Gcommit<cr>', { silent=true, noremap=true })
vim.api.nvim_set_keymap('n', 'gblame','<cmd>Gblame<cr>', { silent=true, noremap=true })
vim.api.nvim_set_keymap('n', 'gpull','<cmd>Gpull<cr>', { silent=true, noremap=true })

-- tagbar
vim.api.nvim_set_keymap('n', '<c-g>','<cmd>Tagbar<cr>', { silent=true, noremap=true })
