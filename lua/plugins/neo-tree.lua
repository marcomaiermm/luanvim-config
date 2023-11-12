local system_open = function(path)
  -- TODO: REMOVE WHEN DROPPING NEOVIM <0.10
  if vim.ui.open then return vim.ui.open(path) end

  local stat = vim.loop.fs_stat(path)
  if not stat then
    -- Handle error if path does not exist
    M.notify("Path does not exist!", vim.log.levels.ERROR)
    return
  end

  local cmd
  if vim.fn.has "win32" == 1 and vim.fn.executable "explorer" == 1 then
    cmd = { "cmd.exe", "/K", "explorer" }
    if stat.type == "directory" then
      table.insert(cmd, "/select,")
    end
  elseif vim.fn.has "unix" == 1 and vim.fn.executable "xdg-open" == 1 then
    cmd = { "xdg-open" }
  elseif (vim.fn.has "mac" == 1 or vim.fn.has "unix" == 1) and vim.fn.executable "open" == 1 then
    cmd = { "open" }
    if stat.type ~= "directory" then
      table.insert(cmd, "-R")
    end
  end

  if not cmd then
    M.notify("Available system opening tool not found!", vim.log.levels.ERROR)
    return
  end

  vim.fn.jobstart(vim.fn.extend(cmd, { path or vim.fn.expand "<cfile>" }), { detach = true })
end


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
            else                           -- if expanded and has children, seleect the next child
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
}
