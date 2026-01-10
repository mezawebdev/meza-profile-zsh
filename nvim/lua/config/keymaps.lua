-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Fix mouse after Wave terminal workspace switch (Wave doesn't send focus events)
vim.keymap.set("n", "<leader>m", function()
  vim.o.mouse = ""
  vim.cmd("redraw")
  vim.o.mouse = "a"
  vim.notify("Mouse reset")
end, { desc = "Reset mouse mode" })
