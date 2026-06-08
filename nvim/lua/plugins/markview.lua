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
          headings = {
            enable = true,
            shift_width = 0,

            -- Top levels: full label "blocks" (background tag) = major sections
            heading_1 = {
              style = "label",
              sign = "󰲡 ", sign_hl = "MarkviewHeading1Sign",
              padding_left = " ", padding_right = " ",
              icon = "󰼏 ", hl = "MarkviewHeading1",
            },
            heading_2 = {
              style = "label",
              sign = "󰲣 ", sign_hl = "MarkviewHeading2Sign",
              padding_left = " ", padding_right = " ",
              icon = "󰎨 ", hl = "MarkviewHeading2",
            },

            -- Lower levels: icon + text only (no block) = clearly subordinate
            heading_3 = { style = "icon", icon = "󰲥 ", hl = "MarkviewHeading3" },
            heading_4 = { style = "icon", icon = "󰲧 ", hl = "MarkviewHeading4" },
            heading_5 = { style = "icon", icon = "󰲩 ", hl = "MarkviewHeading5" },
            heading_6 = { style = "icon", icon = "󰲫 ", hl = "MarkviewHeading6" },
          },
        },
      })

      require("markview.highlights").setup({
        -- Hierarchy via shape + brightness: H1/H2 are bright background blocks,
        -- H3-H6 are fg-only and step noticeably darker each level.
        ["heading"] = {
          { group_name = "MarkviewHeading1", value = { bg = "#3a527e", fg = "#dce8ff", bold = true } },
          { group_name = "MarkviewHeading1Sign", value = { fg = "#9cc4ff" } },
          { group_name = "MarkviewHeading2", value = { bg = "#2c3e5e", fg = "#bcd4fb", bold = true } },
          { group_name = "MarkviewHeading2Sign", value = { fg = "#8fb8f5" } },
          { group_name = "MarkviewHeading3", value = { fg = "#9cc4ff", bold = true } },
          { group_name = "MarkviewHeading4", value = { fg = "#7ea6e0", bold = true } },
          { group_name = "MarkviewHeading5", value = { fg = "#6788b8", bold = true } },
          { group_name = "MarkviewHeading6", value = { fg = "#556b91", bold = true } },
        },
        -- Code blocks: lighter than the super dark background
        ["8"] = {
          { group_name = "MarkviewCode", value = { bg = "#1c1c22" } },
        },
        -- Inline code: neutral, low-saturation (no green-on-green)
        ["9"] = {
          { group_name = "MarkviewInlineCode", value = { fg = "#c5c8d6", bg = "#26262e" } },
        },
        ["MarkviewCodeInfo"] = { fg = "#676e95", bg = "#1c1c22" },
      })
    end,
  },
}
