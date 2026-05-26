return {
  "RRethy/vim-illuminate",
  event = "VeryLazy",
  config = function()
    require("illuminate").configure({
      providers = { "lsp", "treesitter", "regex" },
      delay = 100,
    })
  end,
}
