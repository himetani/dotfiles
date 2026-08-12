-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Emacs-style cursor movement in insert mode.
-- Note: C-n/C-p fall back here only when the blink.cmp menu is hidden
-- (see lua/plugins/blink.lua).
local map = vim.keymap.set
map("i", "<C-a>", "<Home>", { desc = "Beginning of line" })
map("i", "<C-e>", "<End>", { desc = "End of line" })
map("i", "<C-b>", "<Left>", { desc = "Backward char" })
map("i", "<C-f>", "<Right>", { desc = "Forward char" })
map("i", "<C-n>", "<Down>", { desc = "Next line" })
map("i", "<C-p>", "<Up>", { desc = "Previous line" })
map("i", "<C-d>", "<Del>", { desc = "Delete char forward" })
map("i", "<M-b>", "<S-Left>", { desc = "Backward word" })
map("i", "<M-f>", "<S-Right>", { desc = "Forward word" })
