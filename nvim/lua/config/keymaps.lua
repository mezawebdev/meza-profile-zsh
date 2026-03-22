-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Toggle terminal with Ctrl+\
vim.keymap.set({ "n", "t" }, "<C-\\>", function()
  require("snacks").terminal()
end, { desc = "Toggle Terminal" })

-- Copy file paths to clipboard
vim.api.nvim_create_user_command("CopyRelFilePath", function()
  local root = vim.fs.root(0, ".git") or vim.fn.getcwd()
  local abs = vim.fn.expand("%:p")
  if not root:match("/$") then root = root .. "/" end
  local path = abs:sub(#root + 1)
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

-- Insert Mode: Cmd + Arrows (macOS style navigation)
vim.keymap.set("i", "<D-Left>", "<Home>", { desc = "Move to beginning of line" })
vim.keymap.set("i", "<D-Right>", "<End>", { desc = "Move to end of line" })
vim.keymap.set("i", "<D-Up>", "<C-o>gg", { desc = "Move to top of file" })
vim.keymap.set("i", "<D-Down>", "<C-o>G", { desc = "Move to bottom of file" })

-- Bonus: Option + Arrows for jumping by word
vim.keymap.set("i", "<M-Left>", "<C-o>b", { desc = "Jump word left" })
vim.keymap.set("i", "<M-Right>", "<C-o>w", { desc = "Jump word right" })
-- Insert mode: Option + Up/Down to move the current line up or down
vim.keymap.set("i", "<M-Up>", "<Esc>:m .-2<CR>==gi", { desc = "Move line up" })
vim.keymap.set("i", "<M-Down>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down" })
