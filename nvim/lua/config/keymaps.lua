-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Toggle terminal with Ctrl+\
vim.keymap.set({ "n", "t" }, "<C-\\>", function()
  require("snacks").terminal()
end, { desc = "Toggle Terminal" })

-- Copy file paths to clipboard
vim.api.nvim_create_user_command("CopyRelFilePath", function()
  local path = vim.fn.expand("%")
  vim.fn.setreg("+", path)
  vim.notify("Copied: " .. path)
end, {})

vim.api.nvim_create_user_command("CopyAbsFilePath", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify("Copied: " .. path)
end, {})

-- Fix mouse after Wave terminal workspace switch (Wave doesn't send focus events)
vim.keymap.set("n", "<leader>m", function()
  vim.o.mouse = ""
  vim.cmd("redraw")
  vim.o.mouse = "a"
  vim.notify("Mouse reset")
end, { desc = "Reset mouse mode" })
