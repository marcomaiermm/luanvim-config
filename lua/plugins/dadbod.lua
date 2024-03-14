-- https://github.com/tpope/vim-dadbod - Dadbod is a vim plugin for interacting with databases.

return {
  "kristijanhusak/vim-dadbod-ui",
  dependencies = {
    { "akinsho/toggleterm.nvim", lazy = true },
    { "tpope/vim-dadbod", lazy = true },
    { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
  },
  cmd = {
    "DBUI",
    "DBUIToggle",
    "DBUIAddConnection",
    "DBUIFindBuffer",
  },
  init = function()
    -- Your DBUI configuration
    vim.g.db_ui_use_nerd_fonts = 1
    local Terminal = require("toggleterm.terminal").Terminal
    local dbss = Terminal:new({ cmd = "nvim -c :DBUI", hidden = true, direction = "float" })
    function _DBSS()
      dbss:toggle()
    end
  end,
  keys = {
    { "<leader>ud", "<cmd>DBUIToggle<cr>", desc = "Toggle Dadbod UI" },
    { "<leader>uD", "<cmd>lua _DBSS()<cr>", desc = "Toggle Dadbod UI floating Buffer" },
  },
}
