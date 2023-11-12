return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        htmx = {
          filetypes = { "html", "templ" },
          init_options = {
            userLanguages = {
              templ = "html",
            },
          },
        },
      },
    },
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = { "<C-k>", mode = { "i" }, false }
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "htmx-lsp"
      }
    }
  }

}
