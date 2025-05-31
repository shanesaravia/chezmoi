return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      pyright = {
        settings = {
          python = {
            analysis = {
              diagnosticSeverityOverrides = {
                reportMissingParameterType = "warning", -- or "error" if you want it stronger
                reportMissingTypeArgument = "warning",
                reportUnknownParameterType = "warning",
                reportMissingTypeStubs = "information",
              },
              autoImportCompletions = true,
              useLibraryCodeForTypes = true,
            },
          },
        },
      },
      -- ruff_lsp = { enabled = false },
      ruff = { enabled = false },
      eslint = {
        settings = {
          format = false,
          -- autoFixOnSave = true,
          -- run = "onSave",
          -- codeAction = {
          --   showDocumentation = {
          --     enable = true,
          --   },
          -- },
        },
      },
      -- vtsls = {
      --   root_dir = function(fname)
      --     -- Find git root using modern API
      --     return vim.fs.root(fname, ".git") or vim.fs.root(fname, { "package.json", "tsconfig.json" })
      --   end,
      -- },
    },
  },
}
