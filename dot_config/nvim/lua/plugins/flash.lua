return {
  "folke/flash.nvim",
  opts = {
    modes = {
      char = {
        enabled = false, -- This disables f, F, t, T motions
      },
      search = {
        enabled = true, -- Keep search mode
      },
      treesitter = {
        enabled = true, -- Keep treesitter mode
      },
    },
  },
}
