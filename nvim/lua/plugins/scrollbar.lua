return {
  {
    "petertriho/nvim-scrollbar",
    event = "VeryLazy",
    opts = {
      handle = {
        text = " ",
        blend = 40,
        hide_if_all_visible = true,
      },
      handlers = {
        cursor = true,
        diagnostic = true,
        gitsigns = true,
        search = false, -- requires hlslens
      },
    },
  },
}
