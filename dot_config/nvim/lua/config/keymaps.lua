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
