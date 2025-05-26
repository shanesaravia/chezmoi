-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Line diagnostics
vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
-- Prev/Next Completion Item
vim.keymap.set("i", "<c-j>", "<C-n>", { desc = "Next completion item" })
vim.keymap.set("i", "<c-k>", "<C-p>", { desc = "Previous completion item" })
