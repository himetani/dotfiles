-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- Disable the remote plugin providers.
-- Every language server is a self-contained binary, so Neovim needs no external
-- runtime. Leaving the providers enabled makes Neovim probe for node/python3/
-- perl/ruby on startup and report them as missing in :checkhealth.
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
