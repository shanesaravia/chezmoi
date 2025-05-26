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
          -- Enable auto-fixing on save
          autoFixOnSave = true,
          -- Run eslint when you save the file
          run = "onSave",
          -- Enable import organization
          -- codeActionOnSave = {
          --   enable = true,
          --   mode = "all",
          -- },
          codeAction = {
            showDocumentation = {
              enable = true,
            },
          },
        },
      },
    },
  },
}
