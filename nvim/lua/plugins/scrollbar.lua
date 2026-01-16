return {
  {
    "lewis6991/satellite.nvim",
    event = "VeryLazy",
    opts = {
      current_only = false,
      winblend = 50,
      zindex = 40,
      handlers = {
        cursor = { enable = true },
        search = { enable = true },
        diagnostic = {
          enable = true,
          signs = { "-", "=", "≡" }, -- less, equal, more severity
        },
        gitsigns = {
          enable = true,
          signs = {
            add = "│",
            change = "│",
            delete = "_",
          },
        },
        marks = { enable = true },
      },
    },
  },
}
