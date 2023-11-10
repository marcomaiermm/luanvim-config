return {
  "nvim-telescope/telescope.nvim",
  keys = {
    { "<leader>/", false },
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
    { "<leader>fc", "<cmd>Telescope grep_string<cr>", desc = "Find word under cursor" },
    {
      "<leader>fF",
      function()
        require("telescope.builtin").find_files({ hidden = true, no_ignore = true })
      end,
      desc = "Find all Files",
    },
    {
      "<leader>fw",
      function()
        require("telescope.builtin").live_grep()
      end,
      desc = "Find words",
    },
    {
      "<leader>fW",
      function()
        require("telescope.builtin").live_grep({
          additional_args = function(args)
            return vim.list_extend(args, { "--hidden", "--no-ignore" })
          end,
        })
      end,
      desc = "Find words in all files",
    },
  },
  opts = {
    defaults = {
      git_worktrees = vim.g.git_worktrees,
      path_display = { "truncate" },
      sorting_strategy = "ascending",
      layout_config = {
        horizontal = { prompt_position = "top", preview_width = 0.55 },
        vertical = { mirror = false },
        width = 0.87,
        height = 0.80,
        preview_cutoff = 120,
      },
      mappings = {
        i = {
          ["<C-n>"] = require("telescope.actions").cycle_history_next,
          ["<C-p>"] = require("telescope.actions").cycle_history_prev,
          ["<C-j>"] = require("telescope.actions").move_selection_next,
          ["<C-k>"] = require("telescope.actions").move_selection_previous,
        },
        n = { q = require("telescope.actions").close },
      },
    },
  },
}
