-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Disable automatic root detection for monorepos - always use cwd
vim.g.root_spec = { "cwd" }

vim.opt.wrap = true

-- Disable inlay hints (ghost type annotations from LSP)
vim.g.lazyvim_inlay_hints = false
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.lsp.inlay_hint.enable(false, { bufnr = args.buf })
  end,
})

-- Blinking cursor
vim.opt.guicursor = {
  "n-v-c:block-blinkon530-blinkoff530",
  "i-ci-ve:ver25-blinkon530-blinkoff530",
  "r-cr:hor20-blinkon530-blinkoff530",
  "o:hor50",
}
