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
          bg = "#1e1e1e",
        },
        close_button = {
          fg = "#666666",
          bg = "#1e1e1e",
        },
        separator = {
          fg = "#333333",
          bg = "#1e1e1e",
        },
        separator_selected = {
          fg = "#333333",
        },
        -- Fill the empty space in the tab bar
        fill = {
          bg = "#1e1e1e",
        },
        -- Tab numbers area
        tab = {
          bg = "#1e1e1e",
        },
        tab_separator = {
          fg = "#1e1e1e",
          bg = "#1e1e1e",
        },
      },
    },
  },
}
