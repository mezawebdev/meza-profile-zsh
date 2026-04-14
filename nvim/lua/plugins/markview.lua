return {
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local presets = require("markview.presets")

      require("markview").setup({
        markdown = {
          headings = presets.headings.glow,
        },
      })

      require("markview.highlights").setup({
        -- Override heading colors for high-contrast dark backgrounds
        ["heading"] = {
          { group_name = "MarkviewHeading1", value = { bg = "#3b1d5e", fg = "#c792ea", bold = true } },
          { group_name = "MarkviewHeading1Sign", value = { fg = "#c792ea" } },
          { group_name = "MarkviewHeading2", value = { bg = "#1a3a2a", fg = "#c3e88d", bold = true } },
          { group_name = "MarkviewHeading2Sign", value = { fg = "#c3e88d" } },
          { group_name = "MarkviewHeading3", value = { bg = "#2d2a1a", fg = "#ffcb6b", bold = true } },
          { group_name = "MarkviewHeading3Sign", value = { fg = "#ffcb6b" } },
          { group_name = "MarkviewHeading4", value = { bg = "#1a2d3d", fg = "#82aaff", bold = true } },
          { group_name = "MarkviewHeading4Sign", value = { fg = "#82aaff" } },
          { group_name = "MarkviewHeading5", value = { bg = "#3d1a1a", fg = "#ff5370", bold = true } },
          { group_name = "MarkviewHeading5Sign", value = { fg = "#ff5370" } },
          { group_name = "MarkviewHeading6", value = { bg = "#1a3d3d", fg = "#89ddff", bold = true } },
          { group_name = "MarkviewHeading6Sign", value = { fg = "#89ddff" } },
        },
        -- Code blocks: lighter than the super dark background
        ["8"] = {
          { group_name = "MarkviewCode", value = { bg = "#1a1a2e" } },
        },
        ["9"] = {
          { group_name = "MarkviewInlineCode", value = { fg = "#c3e88d", bg = "#1e2a1e" } },
        },
        ["MarkviewCodeInfo"] = { fg = "#676e95", bg = "#1a1a2e" },
      })
    end,
  },
}
