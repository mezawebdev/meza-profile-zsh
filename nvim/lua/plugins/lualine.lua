return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- Remove progress percentage and line:column
      opts.sections.lualine_y = {}
      -- Replace time with project directory name
      opts.sections.lualine_z = {
        {
          function()
            return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
          end,
          icon = "",
        },
      }
    end,
  },
}
