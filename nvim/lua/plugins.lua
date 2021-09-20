local lualine = require('lualine')
lualine.setup {
   options = {
      theme = 'nord',
      icons_enabled = true
   }
}

-- fern.vim
vim.api.nvim_set_var("fern#renderer", "nerdfont")
vim.api.nvim_set_var("cursorhold_updatetime", 100)

-- vim-startify
vim.api.nvim_set_var("startify_bookmarks", {"~/.config/nvim/init.vim", "~/.config/nvim/lua/plugins.lua"})

-- vim-fugitive
vim.api.nvim_set_keymap('n', 'gdiff','<cmd>Gdiffsplit<cr>', { silent=true, noremap=true })
vim.api.nvim_set_keymap('n', 'gblame','<cmd>Gblame<cr>', { silent=true, noremap=true })

-- nvim-colorizer.lua
require'colorizer'.setup()
