-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Line diagnostics
vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
-- Prev/Next Completion Item
vim.keymap.set("i", "<c-j>", "<C-n>", { desc = "Next completion item" })
vim.keymap.set("i", "<c-k>", "<C-p>", { desc = "Previous completion item" })
-- Toggle zoom using Snacks
vim.keymap.set("n", "<leader>z", function()
  Snacks.zen.zoom()
end, { desc = "Toggle Zen Mode" })
-- Buffer search
vim.keymap.set("n", "<leader>bs", function()
  Snacks.picker.buffers()
end, { desc = "Search Buffers" })
-- Temporarily disable some Pyright rules
vim.keymap.set("n", "<leader>xh", function()
  require("lspconfig").pyright.setup({
    settings = {
      python = {
        analysis = {
          reportUnknownParameterType = false,
          reportMissingParameterType = false,
        },
      },
    },
  })
  -- Notify the user
  vim.notify("Pyright: Some rules temprarily disabled. " .. "Please restart LazyVim to re-enable rules")
end, { desc = "Disable some Pyright rules temporarily" })
-- Set default grep to cwd (entire codebase search)
vim.keymap.set("n", "<leader>/", "<cmd>lua Snacks.picker.grep()<cr>", { desc = "Grep (cwd)" })
-- Set default file search to cwd (entire codebase search)
vim.keymap.set("n", "<leader><space>", "<cmd>lua Snacks.picker.files()<cr>", { desc = "Find Files (cwd)" })

-- Reverse file finding
vim.keymap.set("n", "<leader>ff", function()
  require("snacks").picker.files() -- Default is cwd
end, { desc = "Find Files (cwd)" })

vim.keymap.set("n", "<leader>fF", function()
  local root = require("lazyvim.util").root.get()
  require("snacks").picker.files({ cwd = root })
end, { desc = "Find Files (root dir)" })

-- Reverse explorer
vim.keymap.set("n", "<leader>e", function()
  require("snacks").picker.explorer() -- Default is cwd
end, { desc = "Explorer (cwd)" })

vim.keymap.set("n", "<leader>E", function()
  local root = require("lazyvim.util").root.get()
  require("snacks").picker.explorer({ cwd = root })
end, { desc = "Explorer (root dir)" })
