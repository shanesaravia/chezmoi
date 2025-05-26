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
      ruff_lsp = { enabled = false },
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
    },
  },
}
