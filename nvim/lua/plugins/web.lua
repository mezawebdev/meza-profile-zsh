return {
  -- Treesitter parsers for web development
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        -- TypeScript/React
        "tsx",
        "typescript",
        "javascript",
        -- Web
        "html",
        "css",
        "scss",
        -- PHP/Laravel
        "php",
        "blade",
        -- Data formats
        "json",
        "yaml",
        "toml",
      })
    end,
  },

  -- Auto close and rename HTML/JSX tags
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    opts = {},
  },
}
