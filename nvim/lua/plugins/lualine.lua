return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local mode_icons = {
        n = "😎 NORMAL",
        i = "✏️ INSERT",
        v = "👀 VISUAL",
        V = "👀 V-LINE",
        [""] = "👀 V-BLOCK",
        c = "🔧 COMMAND",
        R = "🔄 REPLACE",
        t = "💻 TERMINAL",
        s = "✨ SELECT",
        S = "✨ S-LINE",
      }

      -- Make mode more prominent with icon
      opts.sections.lualine_a = {
        {
          "mode",
          fmt = function(mode)
            local m = vim.fn.mode()
            return mode_icons[m] or mode
          end,
          padding = { left = 1, right = 1 },
        },
      }
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
