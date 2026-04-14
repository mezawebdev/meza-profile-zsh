return {
  {
    "coder/claudecode.nvim",
    event = "VeryLazy",
    config = true,
    opts = {
      -- Don't open Claude in a Neovim terminal - we run it in cmux
      terminal = {
        provider = "none",
      },
    },
    keys = {
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", desc = "Send to Claude", mode = "v" },
      { "<leader>aa", "<cmd>ClaudeCodeAdd<cr>", desc = "Add file to Claude" },
    },
  },
}
