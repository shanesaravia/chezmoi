return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      basedpyright = {
        enabled = true,
        settings = {
          basedpyright = {
            analysis = {
              diagnosticSeverityOverrides = {
                reportUnknownMemberType = false,
                reportUnknownArgumentType = false,
                reportUnknownVariableType = false,
                reportUnknownParameterType = false,
                reportUntypedFunctionDecorator = false,
                reportExplicitAny = false,
                reportAny = false,
                reportUnusedCallResult = false,
              },
              autoImportCompletions = true,
            },
          },
        },
      },
      pyright = {
        enabled = false,
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
          autoFixOnSave = false,
          run = "onSave",
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
