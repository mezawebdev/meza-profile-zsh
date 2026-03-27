return {
  -- 1. Install the theme plugin
  {
    "Mofiqul/vscode.nvim",
    priority = 1000, -- Ensure it loads first
    opts = {
      transparent = true, -- Keep your terminal background (optional)
      italic_comments = true,
      -- You can disable "transparent" if you want the solid gray VS Code background
    },
  },

  -- 2. Make the neo-tree cursor line visible even when unfocused
  {
    "nvim-neo-tree/neo-tree.nvim",
    init = function()
      vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { bg = "#333842", bold = true })
      vim.api.nvim_create_autocmd("WinLeave", {
        pattern = "neo-tree *",
        callback = function()
          vim.wo.cursorline = true
        end,
      })
    end,
  },

  -- 3. Tell LazyVim to use it as the default colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "vscode",
    },
  },
}
