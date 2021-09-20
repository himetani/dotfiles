local neogit = require('neogit')

neogit.setup {
   integrations = {
      diffview = true
   },
}

vim.api.nvim_set_keymap('n', '<leader>g','<cmd>Neogit<cr>', { silent=true, noremap=true })
vim.api.nvim_set_keymap('n', '<leader>d','<cmd>DiffviewOpen<cr>', { silent=true, noremap=true })
