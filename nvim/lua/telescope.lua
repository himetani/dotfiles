custom_live_grep = function()
   local Job = require "plenary.job"
   local builtin = require "telescope.builtin"

   local _, ret = Job:new({
      command = 'git',
      args = { 'rev-parse', '--is-inside-work-tree' },
   }):sync() -- or start()

   if ret ~= 0 then
      builtin.live_grep()
      return
   end

   local git_root, _ = Job:new({
      command = 'git',
      args = { 'rev-parse', '--show-superproject-working-tree', '--show-toplevel' },
   }):sync()

   builtin.live_grep({
      search_dirs=git_root
   })
end

custom_find_files = function()
   local Job = require "plenary.job"
   local builtin = require "telescope.builtin"

   local _, ret = Job:new({
      command = 'git',
      args = { 'rev-parse', '--is-inside-work-tree' },
   }):sync() -- or start()

   if ret ~= 0 then
      builtin.find_files()
      return
   end

   local git_root, _ = Job:new({
      command = 'git',
      args = { 'rev-parse', '--show-superproject-working-tree', '--show-toplevel' },
   }):sync()

   builtin.find_files({
      search_dirs=git_root
   })
end

vim.api.nvim_set_keymap('n', '<leader>l',':lua custom_find_files()<cr>', { silent=true, noremap=true })
vim.api.nvim_set_keymap('n', '<leader>/',':lua custom_live_grep()<cr>', { silent=true, noremap=true })
vim.api.nvim_set_keymap('n', '<leader>m','<cmd>Telescope oldfiles<cr>', { silent=true, noremap=true })
vim.api.nvim_set_keymap('n', '<leader>j','<cmd>Telescope jumplist<cr>', { silent=true, noremap=true })
vim.api.nvim_set_keymap('n', '<leader><C-p>','<cmd>Telescope command_history<cr>', { silent=true, noremap=true })
vim.api.nvim_set_keymap('n', '<leader><C-g>','<cmd>Telescope lsp_document_symbols<cr>', { silent=true, noremap=true })
