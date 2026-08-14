-- Editor toolchain inventory.
--
-- Mason installs into ~/.local/share/nvim/mason, which is added to PATH only
-- inside Neovim. Nothing declared here reaches the global shell PATH.
--
-- Rule: every entry must be a self-contained binary. Packages pulled from the
-- npm or pypi backends need an external runtime that Mason does not manage, and
-- language servers start even outside a project directory, so such a runtime
-- would have to be installed globally. Keeping this list runtime-free is what
-- allows the global environment to stay minimal.
return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "marksman",
        "shfmt",
        "stylua",
        "tree-sitter-cli",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        marksman = {},
      },
    },
  },
}
