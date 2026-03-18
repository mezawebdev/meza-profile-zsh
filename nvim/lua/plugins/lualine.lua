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

      -- Mode with icon
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
      -- Branch only
      opts.sections.lualine_b = { "branch" }
      -- File path breadcrumb — truncate from the left so you always see where you are
      opts.sections.lualine_c = {
        {
          "filename",
          path = 1, -- relative path
          shorting_target = 0, -- don't truncate with dots
        },
      }
      -- Remove diagnostics, progress, line:col
      opts.sections.lualine_x = {}
      opts.sections.lualine_y = {}
      -- Project directory name
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
