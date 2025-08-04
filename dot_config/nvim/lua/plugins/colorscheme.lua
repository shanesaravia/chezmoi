-- Using Lazy
return {
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "tokyonight-storm",
      -- colorscheme = "tokyonight-night",
      -- colorscheme = "onedark"
      -- colorscheme = "carbonfox"
      colorscheme = "nordfox",
    },
  },
  { "shaunsingh/nord.nvim" },
  { "nyoom-engineering/oxocarbon.nvim" },
  {
    "navarasu/onedark.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("onedark").setup({
        style = "darker",
      })
    end,
  },
  { "EdenEast/nightfox.nvim" }, -- lazy
}
