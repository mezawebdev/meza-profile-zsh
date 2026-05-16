return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        explorer = {
          hidden = true,
          ignored = true,
        },
        files = {
          hidden = true,
          ignored = true,
        },
      },
    },
  },
  init = function()
    local function unfade_hidden()
      vim.api.nvim_set_hl(0, "SnacksPickerDirHidden", { link = "SnacksPickerDir" })
      vim.api.nvim_set_hl(0, "SnacksPickerFileHidden", { link = "SnacksPickerFile" })
      vim.api.nvim_set_hl(0, "SnacksPickerPathHidden", { link = "SnacksPickerPath" })
    end
    vim.api.nvim_create_autocmd("ColorScheme", { callback = unfade_hidden })
    unfade_hidden()
  end,
}
