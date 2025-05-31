return {
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        -- python = { "isort", "black" }, -- Make sure isort is listed first
        python = { "ruff_format", "ruff_organize_imports" },
        -- python = { "ruff" },
        javascript = { "eslint_d", "prettierd" },
        javascriptreact = { "eslint_d", "prettierd" },
        typescript = { "eslint_d", "prettierd" },
        typescriptreact = { "eslint_d", "prettierd" },
        vue = { "eslint_d", "prettierd" },
      },
      -- Optional: Explicitly configure isort
      -- formatters = {
      --   isort = {
      --     prepend_args = { "--profile", "black" },
      --   },
      -- },
    },
  },
}
