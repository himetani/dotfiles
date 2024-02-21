return {
  -- https://www.reddit.com/r/neovim/comments/12z0orb/unexpected_behavior_when_pressing_tab_in_insert/
  {
    "L3MON4D3/LuaSnip",
    opts = {
      history = true,
      region_check_events = "InsertEnter",
      delete_check_events = "TextChanged,InsertLeave",
    },
  },
}
