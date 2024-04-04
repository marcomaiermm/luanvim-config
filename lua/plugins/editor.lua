local system_open = require("config.utils").system_open

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      auto_clean_after_session_restore = true,
      close_if_last_window = true,
      filesystem = {
        hijack_netrw_behavior = "open_current",
      },
      commands = {
        system_open = function(state)
          (vim.ui.open or system_open)(state.tree:get_node():get_id())
        end,
        parent_or_close = function(state)
          local node = state.tree:get_node()
          if (node.type == "directory" or node:has_children()) and node:is_expanded() then
            state.commands.toggle_node(state)
          else
            require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
          end
        end,
        child_or_open = function(state)
          local node = state.tree:get_node()
          if node.type == "directory" or node:has_children() then
            if not node:is_expanded() then -- if unexpanded, expand
              state.commands.toggle_node(state)
            else -- if expanded and has children, seleect the next child
              require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
            end
          else -- if not a directory just open it
            state.commands.open(state)
          end
        end,
      },
      window = {
        width = 30,
        mappings = {
          ["<space>"] = false, -- disable space until we figure out which-key disabling
          O = "system_open",
          h = "parent_or_close",
          l = "child_or_open",
          o = "open",
        },
        fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
          ["<C-j>"] = "move_cursor_down",
          ["<C-k>"] = "move_cursor_up",
        },
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>fw",
        function()
          require("telescope.builtin").live_grep()
        end,
        desc = "Find words",
      },
      { "<leader>fc", "<cmd>Telescope grep_string<cr>", desc = "Find word under cursor" },
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
      { "<leader>fl", "<cmd>Telescope resume<cr>", desc = "Resume Find" },
      { "<leader>fd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
      { "<leader>fD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
    },
    opts = {
      defaults = {
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = { prompt_position = "top", preview_width = 0.75 },
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
  },
}
