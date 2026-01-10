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

  -- 2. Tell LazyVim to use it as the default colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "vscode",
    },
  },
}
