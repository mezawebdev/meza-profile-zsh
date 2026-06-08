return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        explorer = {
          hidden = true,
          ignored = true,
          exclude = { ".git" },
        },
        files = {
          hidden = true,
          ignored = true,
          exclude = { "node_modules", ".git" },
        },
        grep = {
          hidden = true,
          ignored = true,
          exclude = { "node_modules", ".git" },
        },
      },
    },
  },
  init = function()
    local function unfade_hidden()
      local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
      vim.api.nvim_set_hl(0, "SnacksPickerPathHidden", { fg = normal.fg })
      vim.api.nvim_set_hl(0, "SnacksPickerPathIgnored", { fg = normal.fg })
    end
    vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, { callback = unfade_hidden })
  end,
}
