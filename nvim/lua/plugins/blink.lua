return {
  -- Let C-n/C-p navigate the completion menu only while it is open;
  -- otherwise fall back to the insert-mode keymaps (Emacs-style line
  -- movement defined in lua/config/keymaps.lua).
  "saghen/blink.cmp",
  opts = {
    keymap = {
      ["<C-n>"] = { "select_next", "fallback" },
      ["<C-p>"] = { "select_prev", "fallback" },
    },
  },
}
