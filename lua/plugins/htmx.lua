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
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "htmx-lsp",
      },
    },
  },
}
