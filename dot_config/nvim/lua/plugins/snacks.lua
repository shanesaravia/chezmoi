return { -- mostly used for its notifications
  "folke/snacks.nvim",
  opts = {
    explorer = {
      follow = "file",
    },
    picker = {
      hidden = true,
      ignored = true,
    },
    styles = {
      notification = {
        wo = {
          wrap = true,
        },
      },
    },
  },
}
