-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Disable automatic root detection for monorepos - always use cwd
vim.g.root_spec = { "cwd" }

-- Use intelephense instead of phpactor (better cross-file gd, no composer.json required at root)
vim.g.lazyvim_php_lsp = "intelephense"

vim.opt.wrap = true

-- Blinking cursor
vim.opt.guicursor = {
  "n-v-c:block-blinkon530-blinkoff530",
  "i-ci-ve:ver25-blinkon530-blinkoff530",
  "r-cr:hor20-blinkon530-blinkoff530",
  "o:hor50",
}
