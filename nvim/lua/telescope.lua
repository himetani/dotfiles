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
vim.api.nvim_set_keymap('n', '<lealer>gst','<cmd>Telescope git_status<cr>', { silent=true, noremap=true })
vim.api.nvim_set_keymap('n', '<leader>gb','<cmd>Telescope git_branches<cr>', { silent=true, noremap=true })
