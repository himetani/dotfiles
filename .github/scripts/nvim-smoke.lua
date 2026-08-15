-- Smoke test for a headless Neovim after a plugin update.
--
-- Looking for error messages does not work. lazy.nvim catches failures and
-- reports them through vim.notify, which does nothing headless, so a config
-- with a Lua syntax error or a plugin whose opts throw still starts silently
-- and exits 0. Nothing reaches stderr or :messages.
--
-- Assert on a real outcome instead. An LSP client attaching to a Lua buffer
-- exercises lazy.nvim, mason and lspconfig together, and was verified to fail
-- when any one of them is broken.

local function fail(message)
  io.stderr:write("SMOKE FAIL: " .. message .. "\n")
  vim.cmd("cquit 1")
end

local probe = vim.fn.tempname() .. ".lua"
vim.fn.writefile({ "local x = 1", "return x" }, probe)
vim.cmd.edit(probe)

-- Mason installs its packages on the first start, so the server may still be
-- downloading when the buffer opens.
vim.wait(60000, function()
  return #vim.lsp.get_clients({ bufnr = 0 }) > 0
end, 200)

local clients = vim.lsp.get_clients({ bufnr = 0 })
if #clients == 0 then
  fail("no LSP client attached to a Lua buffer")
end

if not pcall(vim.treesitter.get_parser, 0, "lua") then
  fail("no treesitter parser for Lua")
end

io.stderr:write("SMOKE OK: lsp=" .. clients[1].name .. "\n")
