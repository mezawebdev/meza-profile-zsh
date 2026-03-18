return {
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        separator_style = "thick",
        tab_size = 22,
        indicator = {
          style = "underline",
        },
      },
      highlights = {
        buffer_selected = {
          bold = true,
          italic = false,
        },
        tab_selected = {
          bold = true,
          italic = false,
        },
        -- Dim inactive tabs
        background = {
          fg = "#666666",
        },
        close_button = {
          fg = "#666666",
        },
        separator = {
          fg = "#333333",
        },
      },
    },
  },
}
