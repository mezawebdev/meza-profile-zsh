return {
  -- Disable neo-tree, use LazyVim's default snacks explorer
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },

  -- Gold directory icons (without affecting file type icons like TypeScript)
  {
    "nvim-mini/mini.icons",
    opts = {
      default = {
        directory = { glyph = "󰉋", hl = "MiniIconsDirectory" },
      },
    },
  },
}
