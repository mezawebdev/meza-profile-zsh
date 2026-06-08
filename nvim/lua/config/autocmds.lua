-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Gold directory icons instead of default blue
vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("custom_directory_colors", { clear = true }),
  callback = function()
    vim.api.nvim_set_hl(0, "MiniIconsDirectory", { fg = "#e8ab53" })
  end,
})
vim.api.nvim_set_hl(0, "MiniIconsDirectory", { fg = "#e8ab53" })

-- Real-time buffer reload via libuv filesystem watcher.
-- Reloads buffers the moment the file changes on disk (e.g. coding agents
-- editing files), without needing the terminal to be focused.
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("fs_watch_reload", { clear = true }),
  callback = function(args)
    local buf = args.buf
    local path = vim.api.nvim_buf_get_name(buf)
    if path == "" or vim.bo[buf].buftype ~= "" then
      return
    end

    local w = vim.uv.new_fs_event()
    if not w then
      return
    end

    local on_change
    on_change = vim.schedule_wrap(function()
      if not vim.api.nvim_buf_is_valid(buf) then
        w:stop()
        return
      end
      vim.api.nvim_buf_call(buf, function()
        vim.cmd("silent! checktime")
      end)
      -- Re-arm: many editors do atomic replace (write tmp + rename), which
      -- invalidates the original inode's watch.
      w:stop()
      vim.defer_fn(function()
        if vim.api.nvim_buf_is_valid(buf) and vim.fn.filereadable(path) == 1 then
          w:start(path, {}, on_change)
        end
      end, 50)
    end)

    w:start(path, {}, on_change)

    vim.api.nvim_create_autocmd("BufWipeout", {
      buffer = buf,
      once = true,
      callback = function()
        w:stop()
      end,
    })
  end,
})
