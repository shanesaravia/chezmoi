return {
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        python = { "isort", "black" }, -- Make sure isort is listed first
        javascript = { "eslint_d", "prettier" },
        javascriptreact = { "eslint_d", "prettier" },
        typescript = { "eslint_d", "prettier" },
        typescriptreact = { "eslint_d", "prettier" },
        vue = { "eslint_d", "prettier" },
      },
      -- Optional: Explicitly configure isort
      formatters = {
        isort = {
          prepend_args = { "--profile", "black" },
        },
      },
    },
  },
}
