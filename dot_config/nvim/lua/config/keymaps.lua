-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Line diagnostics
vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
-- Toggle zoom using Snacks
vim.keymap.set("n", "<leader>z", function()
  Snacks.zen.zoom()
end, { desc = "Toggle Zen Mode" })
-- Buffer search
vim.keymap.set("n", "<leader>bs", function()
  Snacks.picker.buffers()
end, { desc = "Search Buffers" })
-- Buffer move next
vim.keymap.set("n", "<leader>b>", function()
  for _ = 1, vim.v.count1 do
    vim.cmd("BufferLineMoveNext")
  end
end, { silent = true, desc = "Move buffer right" })
-- Buffer move prev
vim.keymap.set("n", "<leader>b<", function()
  for _ = 1, vim.v.count1 do
    vim.cmd("BufferLineMovePrev")
  end
end, { silent = true, desc = "Move buffer left" })
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

-- Reverse grep search
vim.keymap.set("n", "<leader>sg", function()
  require("snacks").picker.grep() -- Default is cwd
end, { desc = "Grep (cwd)" })

vim.keymap.set("n", "<leader>sG", function()
  local root = require("lazyvim.util").root.get()
  require("snacks").picker.grep({ cwd = root })
end, { desc = "Grep (root dir)" })

-- Reverse grep word search
vim.keymap.set({ "n", "x" }, "<leader>sw", function()
  require("snacks").picker.grep_word()
end, { desc = "Visual selection or word (cwd)" })

vim.keymap.set({ "n", "x" }, "<leader>sW", function()
  require("snacks").picker.grep_word({
    cwd = require("lazyvim.util").root.get(),
  })
end, { desc = "Visual selection or word (Root Dir)" })

vim.keymap.set("n", "<C-j>", ":m .+1<CR>==", { desc = "Move line down", silent = true })
vim.keymap.set("n", "<C-k>", ":m .-2<CR>==", { desc = "Move line up", silent = true })
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down", silent = true })
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up", silent = true })
