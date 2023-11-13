return {
  system_open = function(path)
    local stat = vim.loop.fs_stat(path)
    if not stat then
      -- Handle error if path does not exist
      return
    end

    local cmd
    if vim.fn.has("win32") == 1 and vim.fn.executable("explorer") == 1 then
      cmd = { "cmd.exe", "/K", "explorer" }
      if stat.type == "directory" then
        table.insert(cmd, "/select,")
      end
    elseif vim.fn.has("unix") == 1 and vim.fn.executable("xdg-open") == 1 then
      cmd = { "xdg-open" }
    elseif (vim.fn.has("mac") == 1 or vim.fn.has("unix") == 1) and vim.fn.executable("open") == 1 then
      cmd = { "open" }
      if stat.type ~= "directory" then
        table.insert(cmd, "-R")
      end
    end

    if not cmd then
      return
    end

    vim.fn.jobstart(vim.fn.extend(cmd, { path or vim.fn.expand("<cfile>") }), { detach = true })
  end,
}
